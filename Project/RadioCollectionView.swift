//
//  RadioCollectionView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/6.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class RadioCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout{

    let sectionTitle = ["Banner","精彩节目推荐","每天电台精选 - 订阅更精彩","热门电台"]
    
    private let reuseScrollViewInCellID = "ReuseScrollViewInCell"
    private let headerReuseViewID = "HeaderReuseView"
    private let musicCellID = "MusicCell"
    private let bannerCellID = "BannerCell"
    private let RProgrameRecCellID = "RProgrameRecTableViewInCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        dataSource = self
        
        let reuseScrollViewInCellNib = UINib(nibName: reuseScrollViewInCellID, bundle: NSBundle.mainBundle())
        registerNib(reuseScrollViewInCellNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseScrollViewInCellID)
        
        let headerNib = UINib(nibName: headerReuseViewID, bundle: NSBundle.mainBundle())
        registerNib(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseViewID)
        
        let musicNib = UINib(nibName: musicCellID, bundle: NSBundle.mainBundle())
        registerNib(musicNib, forCellWithReuseIdentifier: musicCellID)
        
        let bannerCellNib = UINib(nibName: bannerCellID, bundle: NSBundle.mainBundle())
        registerNib(bannerCellNib, forCellWithReuseIdentifier: bannerCellID)
        
        let RProgrameRecCellNib = UINib(nibName: RProgrameRecCellID, bundle: NSBundle.mainBundle())
        registerNib(RProgrameRecCellNib, forCellWithReuseIdentifier: RProgrameRecCellID)
    }

    //MARK: - Collection view data source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:     return 1
        case 1:     return 1
        case 2:     return 6
        case 3:     return 6
        default:    return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellSection = indexPath.section
        if cellSection == 0 {
            let cell = dequeueReusableCellWithReuseIdentifier(bannerCellID, forIndexPath: indexPath)
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.redColor().CGColor
            return cell
        } else if cellSection == 1 {
            let cell = dequeueReusableCellWithReuseIdentifier(RProgrameRecCellID, forIndexPath: indexPath)
            
            return cell
        } else {
            let cell = dequeueReusableCellWithReuseIdentifier(musicCellID, forIndexPath: indexPath)
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headerView: UICollectionReusableView
        if indexPath.section == 0 {
            headerView = dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: reuseScrollViewInCellID, forIndexPath: indexPath)
        } else {
            headerView = dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseViewID, forIndexPath: indexPath)
            let LB = headerView.viewWithTag(2) as! UILabel
            LB.text = sectionTitle[indexPath.section]
            let leftLogo = headerView.viewWithTag(1) as! UIImageView
            leftLogo.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(4)
                make.height.equalTo(LB.font.pointSize)
            }
            leftLogo.backgroundColor = UIColor.redColor()
            leftLogo.layer.cornerRadius = 2
        }
        return headerView
    }
    
    
    //MARK: - Collection view delegate flow layout
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
        var cellWidth = (innerWidth - 2 * space) / 3
        switch indexPath.section {
        case 0:
            return CGSizeMake(innerWidth, innerWidth * 0.2)
        case 1:
            let height = (RProgrameRecTableViewConstant.cellHeight + 1) * CGFloat(RProgrameRecTableViewConstant.numOfRow)
            return CGSizeMake(innerWidth, height)
        case 2:
            return CGSizeMake(cellWidth, cellWidth + labelHeight)
        default:
            cellWidth = (innerWidth - space) / 2
            return CGSizeMake(cellWidth, cellWidth + labelHeight)
        }
    }
    
}
