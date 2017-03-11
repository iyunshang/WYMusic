//
//  MusicMenuCollectionView.swift
//  Project
//
//  Created by 姜建勇 on 16/8/5.
//  Copyright © 2016年 姜建勇. All rights reserved.
//

import UIKit

class MusicMenuCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var sectionTitle = ["精品歌单"]
    
    private let headerID = "HeaderReuseView"
    private let musicCellID = "MusicCell"
    private let qualityMusicMenuCellID = "QalityMusicMenuCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        // 注册Table View
        // 头部
        let headerNib = UINib(nibName: headerID, bundle: NSBundle.mainBundle())
        registerNib(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        // 音乐Cell
        let musicNib = UINib(nibName: musicCellID, bundle: NSBundle.mainBundle())
        registerNib(musicNib, forCellWithReuseIdentifier: musicCellID)
        
        // 精品歌单Cell
        let qualityMusicNib = UINib(nibName: qualityMusicMenuCellID, bundle: NSBundle.mainBundle())
        registerNib(qualityMusicNib, forCellWithReuseIdentifier: qualityMusicMenuCellID)
    }
    
    //MARK: - Collection view data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row != 0 {
            let cell = dequeueReusableCellWithReuseIdentifier(musicCellID, forIndexPath: indexPath)
            return cell
        } else {
            let cell = dequeueReusableCellWithReuseIdentifier(qualityMusicMenuCellID, forIndexPath: indexPath)
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, forIndexPath: indexPath)
        let headerLogoImgView = headerView.viewWithTag(1) as! UIImageView
        headerLogoImgView.image = UIImage(named: "headerLogo")
        let LB = headerView.viewWithTag(2) as! UILabel
        LB.text = sectionTitle[indexPath.section]
        return headerView
    }
    
    //MARK: - Collection view delegate
    
    
    //MARK: - Collection view delegate flow layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space = flowLayout.minimumInteritemSpacing
        let insetLeft = flowLayout.sectionInset.left
        let windowWidth = collectionView.window!.frame.width
        let innerWidth = windowWidth - insetLeft * 2
        
        if indexPath.row != 0 {
            let cellWidth = (innerWidth - space) / 2
            return CGSizeMake(cellWidth, cellWidth)
        } else {
            let height = innerWidth / 3
            return CGSizeMake(innerWidth, height)
        }
    }

}




























