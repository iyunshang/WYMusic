//
//  BannerScrollView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/2.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import SnapKit

protocol BannerScrollViewDelegate {
    func getSize() -> CGSize
}

/*
    - imageViews的顺序为3，1，2，3，1
    - 将所有的图片加入到ScrollView中
    - 将ScrollView的ContentOffset的横坐标设置为imageViews第二个视图的位置
    - 当视图滚动到imageViews的最后一张时，设置ScrollView的ContentOffset的横坐标为imageViews的第二张的位置
    - 当视图滚动到imageViews的第一张时，设置ScrollView的ContentOffset的横坐标为imageViews的倒数第二张的位置
*/
class ReuseScrollViewInCell: UIScrollView,UIScrollViewDelegate {
    
    var imageViews : [UIImageView]!                     // 滚动视图的一页视图
    private let interval : NSTimeInterval = 3       // 切换页面的时间间隔
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pagingEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        initImage()
    }
    
    private func initImage() {
        imageViews = []
        let leftImage = UIImageView()
        leftImage.backgroundColor = UIColor.yellowColor()
        let centerImage = UIImageView()
        centerImage.backgroundColor = UIColor.brownColor()
        let rightImage = UIImageView()
        rightImage.backgroundColor = UIColor.blueColor()
        imageViews.append(leftImage)
        imageViews.append(centerImage)
        imageViews.append(rightImage)
        
        // 添加相同的最后一张到作为第一张滚动的图，为满足左右滑动
        if imageViews.count > 1 {
            let tmpFirstImage = imageViews.first!.copyView() as! UIImageView
            let tmpLastImageView = imageViews.last!.copyView() as! UIImageView
            imageViews.insert(tmpLastImageView, atIndex: 0)
            imageViews.insert(tmpFirstImage, atIndex: imageViews.count)
            
        }
        loadimageViews()
        
        // 添加定时器
        let timer = NSTimer(timeInterval: interval, target: self, selector: #selector(ReuseScrollViewInCell.changeCurrentImage), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    /**
     * 添加视图
     */
    private func loadimageViews() {
        let width = UIApplication.sharedApplication().keyWindow!.frame.width
        for index in 0 ..< imageViews.count {
            let image = imageViews[index]
            self.addSubview(image)
            image.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self).offset(width * CGFloat(index))
                make.width.equalTo(self.snp_width)
                make.height.equalTo(self.snp_height)
                make.top.equalTo(0)
            })
            image.frame.origin.x = width * CGFloat(index)
        }
        self.contentSize = CGSizeMake(width * CGFloat(imageViews.count), 0)
        //设置图片为第一张
        self.setContentOffset(CGPointMake(width, 0), animated: false)
    }
    
    //MARK: - ScrollViewDelegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let offsetX = scrollView.contentOffset.x
        let lastImageOffsetX = CGFloat(imageViews.count - 1) * screenWidth
        
        if offsetX >= lastImageOffsetX {
            scrollView.setContentOffset(CGPointMake(screenWidth, 0), animated: false)
        } else if offsetX <= 0 {
            scrollView.setContentOffset(CGPointMake(lastImageOffsetX - screenWidth, 0), animated: false)
        }
    }
    
    /**
     * 切换页面
     */
    func changeCurrentImage() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let offsetX = self.contentOffset.x
        let contentWidth = self.contentSize.width
        
        /**
        *   判断contentOffset.x是否是最后一张
        -   如果不是，则切换到下一个视图
        -   如果是，则切换到imageViews的第二张的位置
        */
        if offsetX < contentWidth - screenWidth {
            self.setContentOffset(CGPointMake(offsetX + screenWidth, 0), animated: true)
        } else {
            self.setContentOffset(CGPointMake(screenWidth, 0), animated: false)
        }
    }
    
}

extension UIView {
    // 复制视图
    func copyView() -> UIView {
        let viewData = NSKeyedArchiver.archivedDataWithRootObject(self)
        let cView = NSKeyedUnarchiver.unarchiveObjectWithData(viewData) as! UIView
        return cView
    }
}

























