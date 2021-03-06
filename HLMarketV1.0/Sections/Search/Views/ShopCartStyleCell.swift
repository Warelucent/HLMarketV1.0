//
//  ShopCartStyleCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class ShopCartStyleCell: UICollectionViewCell {
    
    // 上方盒子视图
    lazy var imageBoxView = {UIView.init()}()
    
    // 下方盒子视图
    lazy var asideBoxView = {UIView.init()}()
    
    //下方的上方盒子视图
    lazy var topBoxView = {UIView.init()}()
    
    //下方的下方盒子视图
    lazy var botBoxView = {UIView.init()}()
    
    /// ------ 信息展示视图
    
    lazy var imageView = {() -> UIImageView in
        let view = UIImageView.init()
        return view
    }()
    
    lazy var nameLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    lazy var sepLineLabel = {() -> UILabel in
        let label = UILabel.init()
        label.backgroundColor = UIColor.init(gray: 210)
        return label
    }()
    
    lazy var priceLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.red
        return label
    }()
    
    lazy var shopcartBtn = {() -> UIButton in
        let btn = UIButton(type: UIButtonType.system)
        btn.setImage(UIImage.init(named: "hlm_add_shop_cart"), for: UIControlState.normal)
        return btn
    }()
    
    
    var shopCartModel:ShopCartStyleModel? {
        didSet {
            if (shopCartModel != nil) {
                imageView.image = UIImage.init(named: (shopCartModel?.cGoodsImagePath)!)
                nameLabel.text  = shopCartModel?.cGoodsName
                
                if (shopCartModel?.fVipPrice) != ""{
                    priceLabel.text = "￥" + String.init(format: "%.2f", Float(shopCartModel!.fVipPrice)!)
                }else {
                    priceLabel.text = "￥" + String.init(format: "%.2f", Float(shopCartModel!.fNormalPrice)!)
                }
                
            }
        }
    }
    
    var vADModel:VADModel? {
        didSet {
            if (vADModel != nil) {
                imageView.image = UIImage.init(named: (vADModel?.cGoodsImagePath)!)
                nameLabel.text  = vADModel?.cGoodsName
                
                if (vADModel?.Recommend_price) != ""{
                    priceLabel.text = "￥" + String.init(format: "%.2f", Float(vADModel!.Recommend_price)!)
                }else {
                    priceLabel.text = "￥" + String.init(format: "%.2f", Float(vADModel!.fNormalPrice)!)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        imageBoxView.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(self.snp.width)
        }
        
        
        asideBoxView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageBoxView.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        
        
        //--
        topBoxView.snp.makeConstraints { (make) in
            make.top.left.equalTo(asideBoxView).offset(5)
            make.width.equalTo(asideBoxView).offset(-10)
            make.height.equalTo(asideBoxView).multipliedBy(0.4)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 1, right: 5))
        }
      
        sepLineLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        //--
        botBoxView.snp.makeConstraints { (make) in
            make.left.right.equalTo(topBoxView)
            make.top.greaterThanOrEqualTo(topBoxView.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualTo(asideBoxView.snp.bottom).offset(-5)
        }
        
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.lessThanOrEqualToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
            make.right.equalTo(shopcartBtn.snp.left).offset(-5)
        }
        
        shopcartBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
            make.width.equalTo(shopcartBtn.snp.height)
        }
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //添加视图
        self.contentView.addSubview(imageBoxView)
        self.contentView.addSubview(asideBoxView)
        
        self.imageBoxView.addSubview(imageView)
        
        self.asideBoxView.addSubview(topBoxView)
        self.asideBoxView.addSubview(botBoxView)
        asideBoxView.backgroundColor = UIColor.init(gray: 252)
        self.topBoxView.addSubview(nameLabel)
        self.topBoxView.addSubview(sepLineLabel)
        
        self.botBoxView.addSubview(priceLabel)
//        self.botBoxView.addSubview(price1Label)
        self.botBoxView.addSubview(shopcartBtn)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
