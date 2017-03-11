//
//  OfficialRankTableView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/5.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

struct OfficialRankConstant {
    static let cellHeight : CGFloat = 80
    static let numOfRow : Int = 5
}

class OfficialRankTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    private let reuseCellID = "OfficialRankTableViewCell"
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        let ORNib = UINib(nibName: reuseCellID, bundle: NSBundle.mainBundle())
        registerNib(ORNib, forCellReuseIdentifier: reuseCellID)
    }

    
    // Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OfficialRankConstant.numOfRow
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = dequeueReusableCellWithIdentifier(reuseCellID, forIndexPath: indexPath)
        cell.separatorInset.left = OfficialRankConstant.cellHeight + 5
        return cell
    }
    
    // Table view delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return OfficialRankConstant.cellHeight
    }
}


















