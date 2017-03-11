//
//  MusicCell.swift
//  Project
//
//  Created by 姜建勇 on 16/8/3.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    var longPressGesture : UILongPressGestureRecognizer!    // 长按手势
    
    var image: UIImageView {                                // 歌曲的封面
        return viewWithTag(1) as! UIImageView
    }
    var label: UILabel {                                    // 歌曲的信息
        return viewWithTag(2) as! UILabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //增加长按手势
        longPressGesture = UILongPressGestureRecognizer(target: self, action: Selector("longPressEvent:"))
        self.addGestureRecognizer(longPressGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - 增加音乐封面上的一些其他信息视图
    
    // 播放的封面
    func addPlayCover(view: UIView) {
        
    }
    
    // 左上角
    func addLeftUpView(view: UIView) {
        
    }
    
    // 右上角
    func addRightUpView(view: UIView) {
        
    }
    
    // 左下角
    func addLeftDownView(view: UIView) {
        
    }
    
    // 右下角
    func addRightDownView(view: UIView) {
        
    }
    
}























