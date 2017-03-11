//
//  NoticeTableViewCell.swift
//  Project
//
//  Created by 姜建勇 on 16/8/10.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    
    @IBOutlet weak var publicDateLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    @IBOutlet weak var musicCoverImg: UIImageView!
    @IBOutlet weak var musicLogo: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var musicAuthorLB: UILabel!
    
    
    
    var cell: NoticeTableViewCell {
        return NSBundle.mainBundle().loadNibNamed("NoticeTableViewCell", owner: self, options: nil).first as! NoticeTableViewCell
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: - Event
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    /**
     * 展开
     */
    @IBAction func expandViewBtnClick(sender: AnyObject) {
    }

    /**
     * 关注
     */
    @IBAction func noticeBtnTouch(sender: UIButton) {
    }
    
    /**
     * 转发
     */
    @IBAction func transimitBtnTouch(sender: AnyObject) {
    }
    
    /**
     * 赞
     */
    @IBAction func praiseBtnTouch(sender: UIButton) {
    }
    
    /**
     * 评论
     */
    @IBAction func reviewBtnTouch(sender: AnyObject) {
    }
}























