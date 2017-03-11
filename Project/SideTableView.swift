//
//  SideTableView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/12.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class SideTableView: UITableView,UITableViewDataSource,UITableViewDelegate {

    let user = [["一片空白","[daded] - Alan Walker"],["月","[给我你的爱] - 金志文"],["02","[一生有你] - 66"],["佛易","[Buring] - Maria"],["DD","[如果也听说] - 张惠妹"]]
    
    private let headerViewHeight:CGFloat = 15
    private let topCellHeight: CGFloat = 68
    private let bottomCellHeight: CGFloat = 24
    private let headerViewID = "HeaderView"
    private let topCellID = "SideTableViewTopCell"
    private let bottomCellID = "SideTableViewBottomCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self

        registerClass(SideEmptyHeaderView.self, forHeaderFooterViewReuseIdentifier: headerViewID)
        
        var cellNib = UINib(nibName: topCellID, bundle: NSBundle.mainBundle())
        registerNib(cellNib, forCellReuseIdentifier: topCellID)
        
        cellNib = UINib(nibName: bottomCellID, bundle: NSBundle.mainBundle())
        registerNib(cellNib, forCellReuseIdentifier: bottomCellID)
    }

    //MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return user.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row % 2 == 0 {
            let cell  = dequeueReusableCellWithIdentifier(topCellID, forIndexPath: indexPath)
            return cell
        } else {
            let cell = dequeueReusableCellWithIdentifier(bottomCellID, forIndexPath: indexPath)
            return cell
        }
    }
    
    
    //Table view delegate
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = dequeueReusableHeaderFooterViewWithIdentifier(headerViewID)
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if row % 2 == 0 {
            return topCellHeight
        } else {
            return bottomCellHeight
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}


























