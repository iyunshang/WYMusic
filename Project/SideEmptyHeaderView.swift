//
//  SideEmptyHeaderView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/12.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class SideEmptyHeaderView: UITableViewHeaderFooterView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
    }
}
