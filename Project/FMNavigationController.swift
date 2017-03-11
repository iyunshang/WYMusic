//
//  FMNavigationController.swift
//  Project
//
//  Created by 姜建勇 on 16/8/17.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class FMNavigationController: UINavigationController {

    private var playMusicView: PlayMusic!
    private var FMMusicView: FMMusicCover!
    private var playControlBar: PlayControlBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewWithNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadViewWithNib() {
        let navHeight = navigationBar.frame.height
        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        let playMusicViewHeight = view.frame.height - navHeight
        let playMusicViewFrame = CGRect(origin: CGPointMake(0,navHeight + statusBarHeight), size: CGSizeMake(view.frame.width, playMusicViewHeight - statusBarHeight))
        
        // 初始化视图
        FMMusicView = FMMusicCover()
        playControlBar = PlayControlBar()
        /**
        添加主视图
        - parameter frame: Frame
        - parameter tView: 顶部视图
        - parameter bView: 底部视图
        */
        playMusicView = PlayMusic(frame: playMusicViewFrame,tView: FMMusicView,bView: playControlBar)
        
        // 添加视图
        view.addSubview(playMusicView)
        playMusicView.musicCoverImageView.addBlurEffect()
    }

}
