//
//  HomeClassifyTypeCollectionViewCell.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/13.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

class HomeClassifyTypeCollectionViewCell: UICollectionViewCell {
    
    // 上方盒子视图
    lazy var imageBoxView = {UIView.init()}()
    
    lazy var imageView = {() -> UIImageView in
        let view = UIImageView.init()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    var classifyTypeModel:ClassifyTypeModel? {
        didSet {
            imageView.image = UIImage.init(named: (classifyTypeModel?.cIMG)!)
            nameLabel.text  = classifyTypeModel?.cGroupTypeName
        }
    }
    
    override func layoutSubviews() {
        imageBoxView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(self.snp.height).multipliedBy(0.6)
        }
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageBoxView.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //添加视图
        self.contentView.addSubview(imageBoxView)
        self.contentView.addSubview(nameLabel)
        
        self.imageBoxView.addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

