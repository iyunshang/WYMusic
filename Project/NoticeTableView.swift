//
//  NoticeTableView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/10.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import SnapKit

class NoticeTableView: UITableView,UITableViewDataSource,UITableViewDelegate {

    private let noticeCellID = "NoticeTableViewCell"
    private let headerCellID = "NoticeTableHeaderCell"
    private let headerHeight: CGFloat = 72
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 56
        
        let headerNib = UINib(nibName: headerCellID, bundle: NSBundle.mainBundle())
        registerNib(headerNib, forCellReuseIdentifier: headerCellID)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = dequeueReusableCellWithIdentifier(headerCellID, forIndexPath: indexPath)
            return cell
        } else {
            var cell: NoticeTableViewCell? = dequeueReusableCellWithIdentifier(noticeCellID) as? NoticeTableViewCell
            if cell == nil {
                cell = NoticeTableViewCell().cell
            }
            cell!.userLogo.backgroundColor = UIColor.whiteColor()
            let label = cell?.viewWithTag(5) as? UILabel
            var Str: String = ""
            for _ in 0 ... indexPath.row {
                Str = Str + "12312312312312312312312312312312312312"
            }
            label?.text = Str
            cell?.updateConstraintsIfNeeded()
            return cell!
        }
    }
    
    //MARK: - Table view delegate
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return headerHeight
//        } else {
//            return 360
//        }
//    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return headerHeight
    }
    
}





















