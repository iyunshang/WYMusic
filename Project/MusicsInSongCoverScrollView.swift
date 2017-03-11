//
//  MusicsInSongCoverScrollView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/16.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

protocol MnusicsInSongCoverScrollViewDelegate {
    func swipeLeft()
    func swipeRight()
}

class MusicsInSongCoverScrollView: UIScrollView,UIScrollViewDelegate {

    var songCoverDelegate: SongCoverDelegate?
    var canViews: [MusicCoverImageView] = []
    var didViews: [MusicCoverImageView] = []
    var currentIndex: Int = 0
    
    let rotationAniKey = "rotation"
    
    var currentImage: UIImageView {
//        var _curIndex = currentIndex % didViews.count
//        if currentIndex >= 2 && currentIndex < musicCovers.count - 2 {
//            _curIndex = Int(didViews.count / 2)
//        }
//        print("Index:",currentIndex,_curIndex)
        let _curIndex = Int(contentOffset.x / viewSize.width)
        return didViews[_curIndex]
    }
    
    private var musicCovers: [UIImage]!
    private var canItemCount = 5
    private var startOffsetX: CGFloat = 0
    private var viewSize: CGSize!
    private var precent: CGFloat!
    private var isCenterIndex: Bool = false
    private let animationSpeed: Float = 1.0
    private let duration: NSTimeInterval = 15
    private var moveDif = 0
    
    private var totalItem : Int {
        if musicCovers != nil {
            return musicCovers!.count
        } else {
            return 0
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setup() {
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.pagingEnabled = true
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        viewSize = CGSizeMake(screenWidth, screenWidth)
        
        musicCovers = [
            UIImage(named: "m1")!,
            UIImage(named: "m2")!,
            UIImage(named: "m3")!,
            UIImage(named: "m4")!,
            UIImage(named: "m5")!,
            UIImage(named: "m6")!,
            UIImage(named: "m1")!,
            UIImage(named: "m2")!,
            UIImage(named: "m3")!,
            UIImage(named: "m4")!,
            UIImage(named: "m5")!,
            UIImage(named: "m6")!
        ]
        /**
        *  初始化可用视图队列
        */
        for _ in 0 ... canItemCount {
            let image = MusicCoverImageView(frame: CGRect(origin: CGPointMake(0,0), size: viewSize))
            image.contentMode = .ScaleAspectFit
            canViews.append(image)
        }
        
        /// 填充到已用队列当中
        let min = canItemCount > totalItem ? totalItem : canItemCount
        for index in 0 ..< min {
            let firstImage = canViews.removeFirst()
            firstImage.frame.origin = CGPointMake(viewSize.width * CGFloat(index), 0)
            firstImage.cover.image = musicCovers[index]
            self.addSubview(firstImage)
            didViews.append(firstImage)
        }
        self.contentSize = CGSizeMake(viewSize.width * CGFloat(totalItem), viewSize.height)
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        // 收起手柄
        startOffsetX = scrollView.contentOffset.x
//        print(startOffsetX)
        if songCoverDelegate != nil {
            songCoverDelegate?.handImageViewAnimation(false)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        tran(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // 放下手柄
        if songCoverDelegate != nil {
            songCoverDelegate?.handImageViewAnimation(true)
        }
        
        let endIndex = Int(scrollView.contentOffset.x / viewSize.width)
        var curImageIndex = 0
        if endIndex < 2 {
            curImageIndex = endIndex
        } else if endIndex >= musicCovers.count - 3 {
            curImageIndex = didViews.count - (musicCovers.count - endIndex)
        } else {
            curImageIndex = Int(didViews.count / 2) + moveDif
        }
//        print(curImageIndex)
        musicCoverAnimation(didViews[curImageIndex])
    }
    
    func tran(scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x             // scrollView的内容偏移
        let startIndex = Int(startOffsetX / viewSize.width)         // 滑动前的页面位置
        let endIndex = Int(contentOffsetX / viewSize.width)         // 滑动结束后的页面位置
        let firstViewX = didViews.first!.frame.origin.x             // didView第一个视图的位置
        let lastViewX = didViews.last!.frame.origin.x               // didView最后一个的位置
        let contentWidth = scrollView.contentSize.width             // scrollView内容的宽
        
        // 当滑动到上一视图或下一视图时，恢复视图转动的位置
//        print(startIndex,endIndex)
        if startIndex != endIndex {
            var curImageIndex = 0
            if endIndex < 2 {
                curImageIndex = endIndex
            } else if endIndex >= musicCovers.count - 3 {
                curImageIndex = didViews.count - (musicCovers.count - endIndex)
            } else {
                curImageIndex = Int(didViews.count / 2)
            }
//            musicCoverAnimation(didViews[curImageIndex])
            
            var preImageIndex = 0
            if startIndex < endIndex {
                preImageIndex = curImageIndex - 1
            } else {
                preImageIndex = curImageIndex + 1
            }
            if preImageIndex >= 0 && preImageIndex < didViews.count {
                didViews[preImageIndex].layer.removeAllAnimations()
            }
            
        } else {
            return
        }
        
        // 向左滑
        var unmove = contentOffsetX - firstViewX != 2 * viewSize.width && startOffsetX < contentOffsetX
        
        // 向右滑
        unmove = lastViewX - contentOffsetX != 2 * viewSize.width && startOffsetX > contentOffsetX || unmove
        if unmove {
            return
        }
        print(currentIndex)
        if startOffsetX < contentOffsetX {
            /// 向左滑
            
            // 在 didViews 里出栈一个 ImageView 并改变图片和和位置
            // - 满足当滑动到scrollView的最后一个视图时，不能再想左滑
            // - 满足重用队列didView中的最后一个视图不处于scrollView的末尾
            
            let canMove = lastViewX < contentWidth - viewSize.width
            if canMove {
                let firstImage = didViews.removeFirst()
                var imageIndex = Int(lastViewX / viewSize.width)
                imageIndex += 1
                firstImage.frame.origin.x = lastViewX + viewSize.width
                firstImage.cover.image = musicCovers[imageIndex]
                didViews.append(firstImage)
                moveDif = -1
                
                /// 切换到下一首歌
                
                //改变背景的封面
            }
            
            
            
        } else  {
            /// 向右滑
            
            // 在 didViews 里出栈一个 ImageView 并改变图片和和位置
            if firstViewX > 0 {
                let lastImage = didViews.removeLast()
                var imageIndex = Int(firstViewX / viewSize.width)
                imageIndex -= 1
                lastImage.frame.origin.x = firstViewX - viewSize.width
                lastImage.cover.image = musicCovers[imageIndex]
                didViews.insert(lastImage, atIndex: 0)
                moveDif = 1
                /// 切换到上一首歌
                
                /// 改变背景的封面
            }
            
            
        }
    }
    
    func removeAnimation() {
        
    }
    
    func musicCoverAnimation(view: UIView) {
        var animation = view.layer.animationForKey(rotationAniKey) as? CABasicAnimation
        if animation != nil {
            view.layer.speed = animationSpeed
            view.layer.beginTime = 0
            let timeSincePause = view.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - view.layer.timeOffset
            view.layer.beginTime = timeSincePause
            return
        }
        animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation!.duration = duration
        animation!.fromValue = 0
        animation!.toValue = Float(M_PI * 2)
        animation!.removedOnCompletion = true
        animation!.fillMode = kCAFillModeForwards
        animation!.repeatCount = Float(Int.max)
        view.layer.addAnimation(animation!, forKey: rotationAniKey)
    }
}























