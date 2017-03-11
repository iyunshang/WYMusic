//
//  MyMusicTableViewHeader.swift
//  Project
//
//  Created by 姜建勇 on 16/8/12.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class MyMusicTableViewHeader: UITableViewHeaderFooterView {

    var tapGesture: UITapGestureRecognizer!
    var canExpand: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        contentView.backgroundColor = UIColor.lightTextColor()
    }
}
