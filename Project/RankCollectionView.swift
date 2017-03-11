//
//  OfficialRankCollectionView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/5.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class RankCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let sectionTitle = ["云音乐官方榜","全球榜","用户榜"]
    
    private let headerID = "HeaderReuseView"
    private let musicCellID = "MusicCell"
    private let officialRankCellID = "OfficialRankTableViewInCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        let headerNib = UINib(nibName: headerID, bundle: NSBundle.mainBundle())
        registerNib(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        let musicNib = UINib(nibName: musicCellID, bundle: NSBundle.mainBundle())
        registerNib(musicNib, forCellWithReuseIdentifier: musicCellID)
        
        let officialRankNib = UINib(nibName: officialRankCellID, bundle: NSBundle.mainBundle())
        registerNib(officialRankNib, forCellWithReuseIdentifier: officialRankCellID)
    }
    
    //MARK: - Collection view data source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionTitle[section] {
            case "云音乐官方榜": return 1
            case "全球榜":      return 12
            case "用户榜":      return 2
        default:               return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if sectionTitle[indexPath.section] == "云音乐官方榜" {
            let cell = dequeueReusableCellWithReuseIdentifier(officialRankCellID, forIndexPath: indexPath)
            
            return cell
        } else {
            let cell = dequeueReusableCellWithReuseIdentifier(musicCellID, forIndexPath: indexPath)
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, forIndexPath: indexPath)
        let LB = headerView.viewWithTag(2) as! UILabel
        LB.text = sectionTitle[indexPath.section]
        let leftLogo = headerView.viewWithTag(1) as! UIImageView
        leftLogo.backgroundColor = UIColor.redColor()
        leftLogo.snp_updateConstraints { (make) -> Void in
            make.width.equalTo(4)
            make.height.equalTo(LB.font.pointSize)
        }
        leftLogo.layer.cornerRadius = 2
        return headerView
    }
    
    
    //MARK: - Collection view delegate flow layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space = flowLayout.minimumInteritemSpacing
        let insetLeft = flowLayout.sectionInset.left
        let windowWidth = collectionView.window!.frame.width
        let labelHeight : CGFloat = 26
        let innerWidth = windowWidth - insetLeft * 2
        let cellWidth = (innerWidth - 2 * space) / 3
        switch sectionTitle[indexPath.section] {
        case "云音乐官方榜":
            let height = (OfficialRankConstant.cellHeight + 1) * CGFloat(OfficialRankConstant.numOfRow)
                return CGSizeMake(innerWidth, height)
        default:
            return CGSizeMake(cellWidth, cellWidth + labelHeight)
        }
    }
    
}


















