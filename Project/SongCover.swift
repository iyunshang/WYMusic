//
//  SongCover.swift
//  Project
//
//  Created by 姜建勇 on 16/8/16.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

protocol SongCoverDelegate {
    var playing: Bool{ get set}
    func handImageViewAnimation(isPuff: Bool)
}

class SongCover: UIView,SongCoverDelegate {
    
    @IBOutlet weak var hangImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: MusicsInSongCoverScrollView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    private let nibName = "SongCover"
    private var view: SongCover!
    private var canPlay: Bool = true
    private var imageRotationAni: CAAnimation?
    
    var playing: Bool {
        get {
            return canPlay
        }
        set {
            canPlay = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
        scrollView.songCoverDelegate = self
        moreButton.addTarget(self, action: #selector(SongCover.moreAction), forControlEvents: .TouchUpInside)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initFromNib() {
        view = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil).first as! SongCover
        view.frame.size = frame.size
        addSubview(view)
        let width = UIScreen.mainScreen().bounds.width
        let imageSize = hangImageView.image?.size
        if imageSize == nil {
            return
        }
        self.hangImageView.layer.anchorPoint = CGPointMake(0.5, 24.5 / imageSize!.height)
        let top = (width / imageSize!.width * 48 + hangImageView.frame.origin.y) / 2
        hangImageView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(-top)
        }
    }
    
    func moreAction() {
        handImageViewAnimation(canPlay)
        if canPlay {
            scrollView.musicCoverAnimation(scrollView.currentImage)
        } else {
            scrollView.currentImage.layer.stopAnimation()
        }
    }
    
    func handImageViewAnimation(isPuff: Bool) {
        var angle: CGFloat = 0
        if isPuff {
            angle = CGFloat(M_PI / 4)
        }
        
        // 转动音乐的手柄
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { () -> Void in
            self.hangImageView.transform = CGAffineTransformMakeRotation(angle)
            }, completion: { (com) -> Void in
                self.canPlay = !self.canPlay
        })
    }
    
}

extension CALayer {
    func stopAnimation() {
        let pauseTime = self.convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.speed = 0
        self.timeOffset = pauseTime
    }
    
    func startAniamtion(speed: Float) {
        self.speed = 1
        self.timeOffset = 0
        self.beginTime = 0
    }
}













