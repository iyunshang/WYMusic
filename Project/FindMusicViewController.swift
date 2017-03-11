//
//  FindMusicViewController.swift
//  WYMusic
//
//  Created by 姜建勇 on 16/7/31.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import SnapKit

class FindMusicViewController: UIViewController {
    
    var controlBarView : ControlBarView!                               // 导航条下方的控制条
    
    private let recommendMusicNibName = "RecommendMusicCollectionView" // 个性推荐页面
    private let musicMenuNibName = "MusicMenuCollectionView"           // 歌单页面
    private let radioCNibName = "RadioCollectionView"                  // 主播电台页面
    private let rankNibName = "RankCollectionView"                     // 排行榜页面
    
    private let PlayNavigationControllerID = "PlayNavigationController"
    private let playMusicSBName = "SecondStoryboard"
    
    @IBOutlet var findMusicScrollView : FindMusicScrollView!           // 当前控制器的主滚动视图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setup()
    }
    
    func setup() {
        // 添加导航控制条
        addControlBar()
        
        // 在两个视图间互相共享
        controlBarView.scrollView = findMusicScrollView
        findMusicScrollView.controlBar = controlBarView
        
        // 添加视图
        let screenWidth = self.view.frame.width
        let loadNib = NSBundle.mainBundle().loadNibNamed
        
        // 发现音乐视图
        let RMCollectionView = loadNib(recommendMusicNibName, owner: self, options: nil).first as! RecommendMusicCollectionView
        addFindMusicViews(RMCollectionView, offsetY: 0 * screenWidth)
        
        // 歌单
        let MMCollectionView = loadNib(musicMenuNibName, owner: self, options: nil).first as! MusicMenuCollectionView
        addFindMusicViews(MMCollectionView, offsetY: 1 * screenWidth)
        
        // 主播电台
        let RCollectionView = loadNib(radioCNibName, owner: self, options: nil).first as! RadioCollectionView
        addFindMusicViews(RCollectionView, offsetY: 2 * screenWidth)
        
        // 排行榜视图
        let ORCollectionView = loadNib(rankNibName, owner: self, options: nil).first as! RankCollectionView
        addFindMusicViews(ORCollectionView, offsetY: 3 * screenWidth)
        
        // 设置findMusicScrollView的属性
        findMusicScrollView.contentSize = CGSizeMake(self.view.frame.width * CGFloat(controlBarView.buttons!.count), 0)
    }
    
    /**
     *  在导航条下添加一个控制条
     */
    private func addControlBar() {
        // 添加按钮组
        let recBtn = UIButton()
        recBtn.tag = 0
        recBtn.setTitle("个性推荐", forState: .Normal)
        recBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        let musicMuenBtn = UIButton()
        musicMuenBtn.tag = 1
        musicMuenBtn.setTitle("歌单", forState: .Normal)
        musicMuenBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let radioBtn = UIButton()
        radioBtn.tag = 2
        radioBtn.setTitle("主播电台", forState: .Normal)
        radioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let rankBtn = UIButton()
        rankBtn.tag = 3
        rankBtn.setTitle("排行榜", forState: .Normal)
        rankBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        
        let buttons = [recBtn,musicMuenBtn,radioBtn,rankBtn]
        // 导航条坐下点的Y值
        let cY = (self.navigationController?.navigationBar.frame.origin.y)! + (self.navigationController?.navigationBar.frame.height)!
        let cFrame = CGRectMake(0, cY, self.view.frame.width, 46)
        controlBarView = ControlBarView(frame: cFrame,buttons: buttons)
        controlBarView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(controlBarView)
    }
    
    /**
       在发现音乐滚动视图中添加视图
     
     - parameter FMView:  要添加的视图
     - parameter offsetY: 水平方向的位置
     */
    private func addFindMusicViews(FMView : UIView,offsetY : CGFloat) {
        findMusicScrollView.addSubview(FMView)
        FMView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(controlBarView.frame.height)
            make.left.equalTo(offsetY)
            make.bottom.equalTo(self.view).offset(-1 * self.tabBarController!.tabBar.frame.height)
            make.width.equalTo(self.view.frame.width)
        }
    }
    
    //MARK: - Event
    
    @IBAction func GoPlayMusic(sender: UIBarButtonItem) {
        let playMusicSB = UIStoryboard(name: playMusicSBName, bundle: NSBundle.mainBundle())
        let playMusicController = playMusicSB.instantiateViewControllerWithIdentifier("PlayNavigationController")
        _ = playMusicSB.instantiateViewControllerWithIdentifier("FMNavigationController")
        presentViewController(playMusicController, animated: true, completion: nil)
    }
    
    
    //MARK: - Receive memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


