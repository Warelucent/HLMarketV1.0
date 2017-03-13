//
//  GoodsDetailTableViewCell.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/11.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

class GoodsDetailTableViewCell: UITableViewCell {
    
    // 下方盒子视图
    lazy var asideBoxView = {UIView.init()}()
    
    //下方的上方盒子视图
    lazy var topBoxView = {UIView.init()}()
    
    //下方的下方盒子视图
    lazy var botBoxView = {UIView.init()}()
    
    /// ------ 信息展示视图
    
    lazy var goodsImageView = {() -> UIImageView in
        let view = UIImageView.init()
        return view
    }()
    
    lazy var nameLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 17)
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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.red
        return label
    }()
    
    lazy var price1Label = {() -> GrayLineLabel in
        let label = GrayLineLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var salesLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var stockLabel = {() -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var sepLineLabel1 = {() -> UILabel in
        let label = UILabel.init()
        label.backgroundColor = UIColor.init(gray: 210)
        return label
    }()
    
    lazy var goodsTag1Btn = {() -> UIButton in
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "hlm_goodsTag"), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = false
        btn.alpha = 0.0
        return btn
    }()
    
    lazy var goodsTag2Btn = {() -> UIButton in
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "hlm_goodsTag"), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = false
        btn.alpha = 0.0
        return btn
    }()
    
    lazy var goodsTag3Btn = {() -> UIButton in
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "hlm_goodsTag"), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = false
        btn.alpha = 0.0
        return btn
    }()
    
    var goodsDetailModel:GoodsModel? {
        didSet {
            if (goodsDetailModel != nil) {
                goodsImageView.image = UIImage.init(named: (goodsDetailModel?.cGoodsImagePath)!)
                nameLabel.text  = goodsDetailModel?.cGoodsName
                if (goodsDetailModel?.fVipPrice) != ""{
                    let priceLabelStr = "￥" + String.init(format: "%.2f", Float(goodsDetailModel!.fVipPrice)!)
                    let price1LabelStr = "原价:" + String.init(format: "%.2f", Float(goodsDetailModel!.fNormalPrice)!)
                    priceLabel.text = priceLabelStr
                    price1Label.frame = CGRect(x: priceLabel.frame.origin.x + CGFloat(priceLabelStr.characters.count+1)*10+10, y: priceLabel.frame.origin.y+3, width: CGFloat(price1LabelStr.characters.count+3)*7+1, height: priceLabel.frame.size.height)
                    topBoxView.addSubview(price1Label)
                    price1Label.price = price1LabelStr
                }else {
                    priceLabel.text = "￥" + String.init(format: "%.2f", Float(goodsDetailModel!.fNormalPrice)!)
                }
                salesLabel.text = "销量: 300件"
                stockLabel.text = "库存: 88件"
            }
        }
    }
    
    override func layoutSubviews() {
        goodsImageView.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        
        asideBoxView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(goodsImageView.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        //--
        topBoxView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        sepLineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        salesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.left.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().dividedBy(3)
            make.height.equalToSuperview().dividedBy(3)
        }
        
        stockLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.left.equalTo(salesLabel.snp.right).offset(10)
            make.width.lessThanOrEqualToSuperview().dividedBy(3)
            make.height.equalToSuperview().dividedBy(3)
        }
        
        sepLineLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(topBoxView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        //--
        botBoxView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(topBoxView.snp.bottom)
            make.height.equalToSuperview().dividedBy(4)
        }
        
        goodsTag1Btn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        
        goodsTag2Btn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(goodsTag1Btn.snp.right)
            make.right.equalTo(goodsTag3Btn.snp.left)
        }
        
        goodsTag3Btn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //添加视图
        self.contentView.addSubview(goodsImageView)
        self.contentView.addSubview(asideBoxView)
        
        self.asideBoxView.addSubview(topBoxView)
        self.asideBoxView.addSubview(botBoxView)
        asideBoxView.backgroundColor = UIColor.init(gray: 252)
        self.topBoxView.addSubview(nameLabel)
        self.topBoxView.addSubview(sepLineLabel)
        self.topBoxView.addSubview(priceLabel)
        self.topBoxView.addSubview(salesLabel)
        self.topBoxView.addSubview(stockLabel)
        self.topBoxView.addSubview(sepLineLabel1)
        self.botBoxView.addSubview(goodsTag1Btn)
        self.botBoxView.addSubview(goodsTag2Btn)
        self.botBoxView.addSubview(goodsTag3Btn)
        
        self.selectionStyle = .none
    }
    
    func setgoodsTag(arr: Array<GoodsTagModel>) -> Void {
        for (index,model) in arr.enumerated() {
            switch index {
            case 0:
                goodsTag1Btn.setTitle(model.Describe, for: .normal)
                goodsTag1Btn.alpha = 1.0
            case 1:
                goodsTag2Btn.setTitle(model.Describe, for: .normal)
                goodsTag2Btn.alpha = 1.0
            case 2:
                goodsTag3Btn.setTitle(model.Describe, for: .normal)
                goodsTag3Btn.alpha = 1.0
            default:
                break
            }
        }
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

class GrayLineLabel: UILabel {
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        return lineView
    }()
    
    var price:String? {
        didSet{
            self.text = price
            self.textColor = UIColor.lightGray
            self.textAlignment = .center
            lineView.frame = CGRect(x: 0, y: frame.size.height/2+1, width: frame.size.width, height: 1)
            self.addSubview(lineView)
        }
    }
    
}
