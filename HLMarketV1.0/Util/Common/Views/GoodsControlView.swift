//
//  GoodsControlView.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

enum GoodsControlType {
    case counts
    case plusOrReduce
}


private let kGRadio:CGFloat = 0.618

class GoodsControlView: UIView {
    
    var type:GoodsControlType = .counts

    var model:GoodsControlModel? {
        didSet {
            goodsAvtarView.image = UIImage.init(named: (model?.avtarImage)!)
            titleLabel.text = "品名:\((model?.title)!)"
            priceLabel.text = "价格:\((model?.price)!)"
            switch type {
            case .counts:
                countLabel.text = "x \((model?.count)!)"
                break
            default:
                break
            }
        }
    }
    
    lazy var leftBoxView = {UIView.init()}()
    lazy var rightBoxView = {UIView.init()}()
    
    //左边视图元素
    lazy var goodsAvtarView = {() -> UIImageView in
        let imageview = UIImageView.init()
        imageview.layer.cornerRadius = 3
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    
    lazy var titleLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var priceLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    //右边视图元素
    /* 
        这个视图应该是加减控制按钮的空间视图, 可以自带加减方法, 
        并在每次点击之后可以返回一个数值,
        当数值的值为1的时候, 左边的按钮应该处于不可点击状态
     */
    lazy var plusOrReduceBtn:PPNumberButton = {() -> PPNumberButton in
        let btn = PPNumberButton.init()
        btn.borderColor(UIColor.init(gray: 210))
        return btn
    }()
    
    lazy var countLabel = {() -> UILabel in
        let label = UILabel.init()
        return label
    }()
    
    
    init(frame: CGRect, type:GoodsControlType) {
        super.init(frame: frame)
        
        //self.layer.backgroundColor = UIColor.white.cgColor
        //self.layer.borderColor = UIColor.init(gray: 252).cgColor
        //self.layer.borderWidth = 0.5
        
        self.addSubview(leftBoxView)
        self.addSubview(rightBoxView)
        
        leftBoxView.addSubview(goodsAvtarView)
        leftBoxView.addSubview(titleLabel)
        leftBoxView.addSubview(priceLabel)
        
        self.type = type
        switch type {
        case .counts:
            rightBoxView.addSubview(countLabel)
        default:
            rightBoxView.addSubview(plusOrReduceBtn)
        }
    }
    
    //布局 
    override func layoutSubviews() {
        let kGoodsControlViewMargin:CGFloat = 5
        leftBoxView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(kGoodsControlViewMargin)
            make.bottom.equalTo(self).offset(-kGoodsControlViewMargin)
            make.width.equalTo(self.snp.width).offset(2 * kGoodsControlViewMargin).multipliedBy(kGRadio)
        }
        
        
        goodsAvtarView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(kGoodsControlViewMargin)
            make.bottom.equalToSuperview().offset(-kGoodsControlViewMargin)
            make.width.equalTo(goodsAvtarView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kGoodsControlViewMargin)
            make.left.equalTo(goodsAvtarView.snp.right).offset(kGoodsControlViewMargin)
            make.right.equalToSuperview().offset(-kGoodsControlViewMargin)
            make.height.equalTo(goodsAvtarView.snp.height).multipliedBy(0.4)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.bottom.equalTo(goodsAvtarView.snp.bottom)
        }
        
        rightBoxView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(leftBoxView)
            make.left.equalTo(leftBoxView.snp.right).offset(kGoodsControlViewMargin)
            make.right.equalTo(self).offset(-kGoodsControlViewMargin)
        }
        
        switch type {
        case .counts:
            countLabel.snp.makeConstraints { (make) in
                make.left.equalTo(rightBoxView).offset(kGoodsControlViewMargin)
                make.right.bottom.equalToSuperview().offset(-kGoodsControlViewMargin)
                make.height.equalTo(20)
            }
            break
        default:
            plusOrReduceBtn.snp.makeConstraints { (make) in
                make.left.equalTo(rightBoxView).offset(kGoodsControlViewMargin)
                make.right.bottom.equalToSuperview().offset(-kGoodsControlViewMargin)
                make.height.equalTo(30)
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}






