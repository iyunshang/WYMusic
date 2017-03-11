//
//  RateProgressView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/15.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class RateSlider: UISlider {

    @IBInspectable var thumbImage: UIImage {
        get {
            return currentThumbImage!
        }
        set {
            setThumbImage(newValue, forState: .Normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
