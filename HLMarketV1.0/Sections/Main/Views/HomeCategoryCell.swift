//
//  HomeCategoryCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SnapKit


class HomeCategoryCell: UICollectionViewCell {
    
    //盒子视图
    lazy var cellBoxView:UIView = {UIView.init()}()
    
    //图片
    lazy var cellImageView:UIImageView = {UIImageView.init()}()
    
    //标签
    lazy var cellLabel:UILabel = {()->UILabel in
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    
    
    var cellModel:CellCycleModel? {
        didSet {
            cellLabel.text = cellModel?.text
            cellImageView.image = UIImage.init(named: (cellModel?.imageName)!)
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(cellBoxView)
        self.cellBoxView.addSubview(cellImageView)
        self.cellBoxView.addSubview(cellLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        cellBoxView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10));
        }
        cellImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(cellBoxView).multipliedBy(0.5)
            make.centerX.equalTo(cellBoxView)
            make.width.height.equalTo(self).multipliedBy(0.5)
        }
        cellLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(cellImageView)
            make.bottom.equalTo(cellBoxView.snp.bottom).offset(-5)
            make.top.equalTo(cellImageView.snp.bottom).offset(5)
        }
    }
    

}
