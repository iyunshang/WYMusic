//
//  FindMusicScrollVIew.swift
//  Project
//
//  Created by 姜建勇 on 16/8/2.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class FindMusicScrollView: UIScrollView,UIScrollViewDelegate {
    
    var controlBar : ControlBarView?// 导航条下的控制条
    
    var curOffsetX : CGFloat!       // Scroll view 将要开始移动的内容偏移量
    var curPositionX : CGFloat!     // Scroll view 将要开始移动controlBar的位置
    var curWidth : CGFloat!         // Scroll view 将要开始移动controlBar的宽
    var curBtnIndex : Int!          // controlBar 当前所在的按钮
    var precent : CGFloat = 0       // Scroll view 将要移动的的百分比
    var isScrollCase : Bool = false // 标示Scroll view的滚动是否是用户滑动而非点击按钮
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        curBtnIndex = 0
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        curOffsetX = scrollView.contentOffset.x
        curPositionX = controlBar!.selectLineLayer.frame.origin.x
        curWidth = controlBar!.selectLineLayer.frame.width
        isScrollCase = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !isScrollCase {
            return
        }
        let scrollViewWidth = scrollView.frame.width
        let contentOffsetX = scrollView.contentOffset.x
        let thisScreenContentOffsetX = fabs(contentOffsetX - curOffsetX)                // 移动的偏移量
        precent = thisScreenContentOffsetX / scrollViewWidth
        if contentOffsetX < curOffsetX {
            // 向右滑
            curBtnIndex = Int((curOffsetX / scrollViewWidth) - 1)   // 获得前一个按钮的index
            if precent > 1.0 {
                if curBtnIndex > 0 {
                    precent = 1
                }
            }
            if curBtnIndex < 0 {
                return
            }
        } else if contentOffsetX > curOffsetX {
            // 向左滑
            curBtnIndex = Int((curOffsetX / scrollViewWidth) + 1)   // 获得前一个按钮的index
            if precent > 1.0 {
                if curBtnIndex < controlBar!.buttons!.count - 1 {
                    curBtnIndex = curBtnIndex + 1
                    precent = 1
                }
            }
            if curBtnIndex >= controlBar?.buttons?.count {
                return
            }
        }
        
        let preBtn = controlBar?.buttons![curBtnIndex]
        let difSpace =   preBtn!.frame.origin.x - curPositionX      // 两个按钮之间的距离
        let difWidth = preBtn!.frame.width - curWidth               // 两个按钮宽的差
        controlBar?.selectLineLayer.frame.origin.x = curPositionX + difSpace * precent
        controlBar?.selectLineLayer.frame.size.width = curWidth + difWidth * precent
    }
}



















