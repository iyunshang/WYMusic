//
//  PlayMusic.swift
//  Project
//
//  Created by 姜建勇 on 16/8/16.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import SnapKit

class PlayMusic: UIView {

    @IBOutlet weak var musicCoverImageView: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    private var view: PlayMusic!
    private let nibName = "PlayMusic"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    /**
        初始化，并且添加顶部和底部视图
     
     - parameter frame: Frame
     - parameter tView: 顶部视图
     - parameter bView: 底部视图

     */
    init(frame: CGRect,tView: UIView,bView: UIView) {
        super.init(frame: frame)
        initFromNib()
        topView.addSubview(tView)
        bottomView.addSubview(bView)
        tView.snp_equalToView(topView)
        bView.snp_equalToView(bottomView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func initFromNib() {
        view = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil).first as! PlayMusic
        addSubview(view)
        view.snp_equalToView(self)
    }
    
    func addChildView(topView: UIView,bottom: UIView) {
        
    }
}

extension UIView {
    func snp_equalToView(view: UIView) {
        self.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    func addBlurEffect() {
        let blur = UIBlurEffect(style: .Light)
        let effectView = UIVisualEffectView(effect: blur)
        let vibrancyEffect = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .Light)))
        vibrancyEffect.frame = self.frame
        effectView.frame = self.frame
        self.insertSubview(effectView, aboveSubview: self)
        self.insertSubview(vibrancyEffect, aboveSubview: self)
    }
}





















