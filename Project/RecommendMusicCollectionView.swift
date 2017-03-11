//
//  FindMusicCollectionView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/3.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class RecommendMusicCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private let nibName = "FindMusicCollectionView"
    private let musicCellID = "MusicCell"
    private let controlCellID = "ControlCell"
    private let reuseScrollViewInCellID = "ReuseScrollViewInCell"
    private let headerReuseViewID = "HeaderReuseView"
    
    var sectionTitle : [String] = ["Banner","最新音乐","推荐歌曲","独家放送","推荐MV","主播电台"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.dataSource = self
        let MCNib = UINib(nibName: musicCellID, bundle: NSBundle.mainBundle())
        let CCNib = UINib(nibName: controlCellID, bundle: NSBundle.mainBundle())
        let BRNib = UINib(nibName: reuseScrollViewInCellID, bundle: NSBundle.mainBundle())
        let HRNib = UINib(nibName: headerReuseViewID, bundle: NSBundle.mainBundle())
        self.registerNib(MCNib, forCellWithReuseIdentifier: musicCellID)
        self.registerNib(CCNib, forCellWithReuseIdentifier: controlCellID)
        self.registerNib(BRNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseScrollViewInCellID)
        self.registerNib(HRNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseViewID)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionTitle[section] {
        case "推荐歌曲","主播电台","最新音乐": return 6
        case "独家放送": return 3
        case "推荐MV": return 4
        default: return 3
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(controlCellID, forIndexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(musicCellID, forIndexPath: indexPath) as! MusicCell
            return cell
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reuseView : UICollectionReusableView
        if indexPath.section == 0 {
            reuseView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: reuseScrollViewInCellID, forIndexPath: indexPath)
        } else {
            reuseView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseViewID, forIndexPath: indexPath)
            let headerLogoImgView = reuseView.viewWithTag(1) as! UIImageView
            headerLogoImgView.image = UIImage(named: "headerLogo")
            let LB = reuseView.viewWithTag(2) as! UILabel
            LB.text = sectionTitle[indexPath.section]
        }
        return reuseView
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var headerWidth : CGFloat
        if section == 0 {
            headerWidth = collectionView.window!.frame.width * 0.36
        } else {
            headerWidth = 48
        }
        return CGSizeMake(self.window!.frame.width, headerWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space = flowLayout.minimumInteritemSpacing
        let insetLeft = flowLayout.sectionInset.left
        let windowWidth = collectionView.window!.frame.width
        let labelHeight : CGFloat = 26
        let innerWidth = windowWidth - insetLeft * 2
        var cellWidth = (innerWidth - space) / 3
        switch sectionTitle[indexPath.section] {
        case "推荐歌曲","主播电台","最新音乐":
            return CGSizeMake(cellWidth, cellWidth + labelHeight)
        case "独家放送":
            if indexPath.row == 2 {
                return CGSizeMake(innerWidth + space, cellWidth)
            } else {
                fallthrough
            }
        case "推荐MV":
        let height = cellWidth
        cellWidth = innerWidth / 2
        return CGSizeMake(cellWidth, height + labelHeight)
        default:
            return CGSizeMake(cellWidth, cellWidth + labelHeight)
        }
    }
}















