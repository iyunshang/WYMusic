//
//  FMMusicCover.swift
//  Project
//
//  Created by 姜建勇 on 16/8/16.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class FMMusicCover: UIView {

    @IBOutlet weak var musicCoverImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    private var view: FMMusicCover!
    private let nibName = "FMMusicCover"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initFromNib() {
        view = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil).first as! FMMusicCover
        view.frame.size = frame.size
        addSubview(view)
        musicCoverImageView.clipsToBounds = true
    }
}
