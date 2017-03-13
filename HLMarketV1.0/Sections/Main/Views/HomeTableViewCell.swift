//
//  HomeTableViewCell.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/13.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let size = CGSize(width:CViewCellWid, height:CViewCellHei)
        layout.itemSize = size
        layout.minimumLineSpacing = CViewCellMargin
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: CViewCellMargin, left: CViewCellMargin, bottom: CViewCellMargin, right: CViewCellMargin)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        collectionView.isScrollEnabled = false
        collectionView.register(HomeClassifyTypeCollectionViewCell.self, forCellWithReuseIdentifier: ClassifyTypeColViewCellID)
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    lazy var collectionView1: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let size = CGSize(width:CViewCellWid1, height:CViewCellWid1*1.5)
        layout.itemSize = size
        layout.minimumLineSpacing = CViewCellMargin
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: CViewCellMargin, left: CViewCellMargin, bottom: CViewCellMargin, right: CViewCellMargin)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        collectionView.isScrollEnabled = false
        collectionView.register(ShopCartStyleCell.self, forCellWithReuseIdentifier: VADColViewCellID)
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
