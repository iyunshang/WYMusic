//
//  MusicCoverImageView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/17.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class MusicCoverImageView: UIImageView {
    
    var cover: UIImageView!
    
    private let imageName = "MusicPP"
    private let innerCycleOriginWidth: CGFloat = 280
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        image = UIImage(named: imageName)
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let bgImageWidth = image!.size.width
        let coverWidth = (innerCycleOriginWidth / bgImageWidth) * screenWidth
        let coverSize = CGSizeMake(coverWidth,coverWidth)
        let coverOriginX = (screenWidth - coverWidth) / 2
        let coverOrigin = CGPointMake(coverOriginX, coverOriginX)
        cover = UIImageView(frame: CGRect(origin: coverOrigin, size: coverSize))
        cover.layer.cornerRadius = coverWidth / 2
        cover.clipsToBounds = true
        addSubview(cover)
    }
}

extension UIImageView {
    func addRadius(radius: CGFloat) {
        let center = frame.size.width / 2
        let context = UIGraphicsGetCurrentContext()
        UIGraphicsBeginImageContext(self.frame.size)
        CGContextAddArc(context, center, center, center, 0, CGFloat(2.0 * M_PI), 1)
        CGContextDrawPath(context, .Fill)
        let outputImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = outputImg
    }
}
