//
//  MyMusicTableViewController.swift
//  Project
//
//  Created by 姜建勇 on 16/8/7.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class MyMusicTableViewController: UITableViewController {

    var canExpand: Bool = true
    
    let musicTitles = ["下载音乐","最近播放","iPod","我的歌手"]                  // 系统歌单Cell title
    let myMusicTitles = ["我喜欢的音乐","欢快","轻松","愉悦","清纯","悲伤"]       // 用户自定义歌单Cell title
    
    private let headerNibName = "MyMusicTableViewHeader"
    private let musicListCellID = "MusciListCell"
    private let myMusicListCellID = "MyMusicMenuCell"
    private let headerHeight: CGFloat = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return musicTitles.count
        } else if canExpand {
            return myMusicTitles.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let section = indexPath.section
        var leftImageView: UIImageView
        if section == 0 {
            /**
               系统歌单
            -  @param musicListCellID 系统歌单CellID
            */
            cell = tableView.dequeueReusableCellWithIdentifier(musicListCellID, forIndexPath: indexPath)
            leftImageView = cell.viewWithTag(1) as! UIImageView
            let cellTitleLB = cell.viewWithTag(2) as! UILabel
            cellTitleLB.text = musicTitles[indexPath.row]
        } else {
            /**
               用户自定义歌单
            -  myMusicListCellID: 自定义歌单的CellID
            */
            cell = tableView.dequeueReusableCellWithIdentifier(myMusicListCellID, forIndexPath: indexPath)
            leftImageView = cell.viewWithTag(1) as! UIImageView
        }
        let separatorLeft = leftImageView.frame.width + leftImageView.frame.origin.x + 10
        cell.separatorInset.left = separatorLeft
        return cell
    }

    
    //MARK: - Table View delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = NSBundle.mainBundle().loadNibNamed(headerNibName, owner: self, options: nil).first as! MyMusicTableViewHeader
            headerView.tapGesture.addTarget(self, action: #selector(MyMusicTableViewController.toggleTableViewAction))
            return headerView
        }
    }

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return headerHeight
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    
    //MARK: - Event
    
    /**
     * 展开或关闭第二部分
    */
    func toggleTableViewAction() {
        canExpand = !canExpand
        tableView.reloadData()
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


























