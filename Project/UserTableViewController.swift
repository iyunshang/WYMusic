//
//  SettingTableViewController.swift
//  Project
//
//  Created by 姜建勇 on 16/8/5.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    let cellTitles = [
        ["我的消息"],
        ["会员中心","积分商城","在线听歌免流量"],
        ["设置","主题换肤","夜间模式","定时关闭","音乐闹钟","驾驶模式"],
        ["分享网易云音乐","关于"],
    ]
    // Table view 初始的内容偏移和Cell初始大小
    private var originContentOffset : CGPoint!
    private var originCellHeight : CGFloat! = 0
    private let userProfileCellHeight: CGFloat = 68
    private let userInfoCellHeight: CGFloat = 56
    
    private let userProfileCellID = "UserProfileCell"
    private let userInfoCellID = "UserInfoCell"
    private let usuallyCellID = "UsuallyCell"
    private let exitCellID = "ExitCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //获取初始的偏移量
        originContentOffset = tableView.contentOffset
        originCellHeight = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))?.frame.height
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 6
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:         return 2                                // 第一Section
        case 1,2,3,4:   return cellTitles[section - 1].count
        case 5:         return 1                                // 退出Cell
        default:        return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier(userProfileCellID, forIndexPath: indexPath)
            } else {
                
                /* Tag value:
                - 1: 动态按钮
                - 2: 关注按钮
                - 3: 粉丝按钮
                - 4: 编辑资料按钮
                */
                
                cell = tableView.dequeueReusableCellWithIdentifier(userInfoCellID, forIndexPath: indexPath)
            }
        case 1,2,3,4:
            
            /* Tag value:
            - 1: Cell logo
            - 2: Cell title
            - 3: Cell的图片
            - 4: Cell是否有详情页面
            */
            
            cell = tableView.dequeueReusableCellWithIdentifier(usuallyCellID, forIndexPath: indexPath)
            let titleLabel = cell.viewWithTag(2) as! UILabel
            titleLabel.text = cellTitles[indexPath.section - 1][indexPath.row]
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier(exitCellID, forIndexPath: indexPath)
        default: cell = UITableViewCell()
        }
        
        return cell
    }

    //MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 9
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return userProfileCellHeight
            } else {
                return userInfoCellHeight
            }
        default :
            return tableView.rowHeight
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    // MARK: - Scroll view delegate
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard let OCOffset = originContentOffset else {
            return
        }
        // 拉长第一个Cell
        if offsetY < originContentOffset.y {
            let indexPath = NSIndexPath(forItem: 0, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            let cellHeight = cell?.frame.size.height
            if cellHeight >= originCellHeight {
                cell?.frame.size.height = originCellHeight + fabs(offsetY - originContentOffset.y)
                cell?.frame.origin.y = offsetY - originContentOffset.y
            }
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // 还原Cell的高度
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.frame.origin.y != 0 || cell?.frame.size.height == originCellHeight {
            cell?.frame.origin.y = 0
            cell?.frame.size.height = self.originCellHeight
        }
    }

}
