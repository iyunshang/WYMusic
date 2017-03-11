//
//  PlayControlBar.swift
//  Project
//
//  Created by 姜建勇 on 16/8/15.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class PlayControlBar: UIView {
    
    @IBOutlet weak var completedTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var musicControlButton1: UIButton!
    @IBOutlet weak var musicControlButton2: UIButton!
    @IBOutlet weak var musicControlButton3: UIButton!
    @IBOutlet weak var musicControlButton4: UIButton!
    @IBOutlet weak var musicControlButton5: UIButton!
    
    private var view: PlayControlBar!
    private let nibName = "PlayControlBar"
    
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
        view = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil).first as! PlayControlBar
        view.frame.size = frame.size
        addSubview(view)
        view.snp_equalToView(self)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
