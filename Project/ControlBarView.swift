//
//  ControlBarView.swift
//  WYMusic
//
//  Created by 姜建勇 on 16/8/1.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import SnapKit

class ControlBarView: UIView {
    
    var buttons : [UIButton]?               // 按钮组
    var selectLineLayer : CALayer!          // 线条
    var scrollView : UIScrollView?          // 滚动视图
    
    private var curItemIndex : Int!         // 当前的按钮
    private var curContenOffsetX : CGFloat! // 当前滚动视图的在X方向的偏移量
    private let padding : CGFloat = 10      // 最左按钮距左的距离
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame : CGRect,buttons : [UIButton]) {
        super.init(frame: frame)
        // 添加按钮
        self.buttons = buttons
        addButtonsToView()
        
        // 添加线条
        selectLineLayer = CALayer()
        selectLineLayer.backgroundColor = UIColor.redColor().CGColor
        // 计算线条的位置
        let titleLB = buttons.first!.titleLabel!
        let width = CGFloat(titleLB.text!.characters.count) * titleLB.font.pointSize
        selectLineLayer.frame = CGRectMake(padding,self.frame.height - 2,width,2)
        self.layer.addSublayer(selectLineLayer)
        
        // 初始化状态
        curItemIndex = 0
        curContenOffsetX = 0
    }
    
    /**
     *  重绘背景
     */
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let size = self.frame.size
        CGContextSetLineWidth(context, 1.0)
        CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 0, size.height)
        CGContextAddLineToPoint(context, size.width, size.height)
        CGContextStrokePath(context)
        CGContextClosePath(context)
    }

    /**
     * 添加按钮组
     */
    private func addButtonsToView() {
        guard let btns = buttons else {
            return
        }
        let countBtns = buttons!.count
        switch countBtns {
        case 1:
            let btn = buttons!.first!
            self.addSubview(btn)
            btn.snp_makeConstraints(closure: { (make) -> Void in
                make.center.equalTo(self)
            })
        default:
            addItems()
        }
    }
    
    /**
     * 计算按钮之间的距离
     - returns: 返回两个按钮之间的距离
     */
    private func calaDistanceOfBtns() -> CGFloat {
        let viewWidth = self.frame.width
        
        // 获取所有按钮的宽度
        if buttons?.count == 1 {
            return 0
        } else {
            var countWidth : CGFloat = 0
            for btnIndex in 0 ... buttons!.count - 1 {
                let titleLabel = buttons![btnIndex].titleLabel!
                let width = CGFloat(titleLabel.text!.characters.count) * titleLabel.font.pointSize
                countWidth += width
            }
            
            // 计算处第一个和最后一个按钮之间的距离
            return ((viewWidth - padding * CGFloat(2)) - countWidth) / CGFloat(buttons!.count - 1)
        }
    }
    
    func addItems() {
        guard let btns = buttons else {
            return
        }
        // 获取所有按钮的宽度
        var item : UIButton
        var left : CGFloat = 0
        let itesSpace = calaDistanceOfBtns()
        for btnIndex in 0 ... buttons!.count - 1 {
            /*
            * 
            */
            let titleLabel = buttons![btnIndex].titleLabel!
            let pointSize = titleLabel.font.pointSize
            let width = CGFloat(titleLabel.text!.characters.count) * pointSize
            let positionY = (self.frame.height - pointSize - 2) / 2
            if btnIndex != 0 {
                let preItemWidth = CGFloat(buttons![btnIndex - 1].titleLabel!.text!.characters.count) * pointSize
                left = itesSpace + buttons![btnIndex - 1].frame.origin.x + preItemWidth
            } else {
                left = 10
            }
            item = buttons![btnIndex]
            item.frame = CGRectMake(left, positionY, width, pointSize + 4)
            item.addTarget(self, action: #selector(ControlBarView.controlBarButtonItemTouch(_:)), forControlEvents: .TouchUpInside)
            addSubview(item)
        }
    }
    
    /**
     * 移动下方的线条
     
     - parameter buttonIndex: 单击按钮的位置
     */
    func moveLine(buttonIndex buttonIndex: Int) {
        let offsetX = CGFloat(buttonIndex) * self.frame.width
        if curContenOffsetX != offsetX {
            // 设置Scroll view 偏移到相应的位置
            scrollView?.setContentOffset(CGPointMake(offsetX, 0), animated: false)
            // 获得点击按钮的坐标和宽
            let lineWidth = buttons![buttonIndex].frame.width
            let moveX = buttons![buttonIndex].frame.origin.x
            
            // 添加位置动画
            let posAni = CABasicAnimation(keyPath: "position.x")
            posAni.duration = 0.3
            posAni.fromValue = selectLineLayer.frame.origin.x
            posAni.toValue = moveX
            
            // 宽动画
            let widthAni = CABasicAnimation(keyPath: "bounds.size.width")
            widthAni.duration = 0.3
            widthAni.fromValue = selectLineLayer.frame.width
            widthAni.toValue = lineWidth
            
            // 将位置和宽的动画合成一个组动画
            let aniGroup = CAAnimationGroup()
            aniGroup.animations = [posAni,widthAni]
            selectLineLayer.anchorPoint = CGPointMake(0, 0)
            selectLineLayer.addAnimation(aniGroup, forKey: "line")
            
            // 将线条的位置和长置为点击后的位置
            selectLineLayer.frame.origin.x = moveX
            selectLineLayer.frame.size.width = lineWidth
            
            // 保存移动后的状态
            curItemIndex = buttonIndex
            curContenOffsetX = scrollView?.contentOffset.x
        }
    }
    
    /**
     * 按钮被单击
     */
    func controlBarButtonItemTouch(sender: UIButton) {
        moveLine(buttonIndex: sender.tag)
    }
    
    
}













