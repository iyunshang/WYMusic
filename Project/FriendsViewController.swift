//
//  FriendsViewController.swift
//  Project
//
//  Created by 姜建勇 on 16/8/7.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var navSegmented: UISegmentedControl!        // 导航条中间的选择器
    @IBOutlet weak var scrollView: UIScrollView!                // 控制器主滚动条，在关注视图和附近视图切换
    
    private let noticeNibName = "NoticeTableView"
    private let sideNibName = "SideTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setup()
    }

    private func setup() {
        let noticeTableView = NSBundle.mainBundle().loadNibNamed(noticeNibName, owner: nil, options: nil).first as! NoticeTableView
        scrollView.addSubview(noticeTableView)
        noticeTableView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
        
        let sideTableView = NSBundle.mainBundle().loadNibNamed(sideNibName, owner: self, options: nil).first as! SideTableView
        scrollView.addSubview(sideTableView)
        sideTableView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.left.equalTo(scrollView).offset(view.frame.width)
            make.top.equalTo(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func navSegmentedValueChange(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if selectedIndex == 0 {
            scrollView.setContentOffset(CGPointMake(0,0), animated: false)
        } else {
            let viewWidth = self.view.frame.width
            scrollView.setContentOffset(CGPointMake(viewWidth, 0), animated: false)
        }
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
