//
//  HomeHeaderView.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SnapKit


protocol HomeHeaderViewDelegate:class {
    func moreLivingList(cataName: String, titleName: String)
}

class HomeHeaderView: UICollectionReusableView {
    
    lazy var headerBoxView = {UIView.init()}()
    lazy var titleLabel = {UILabel.init()}()
    lazy var iconImageView = {UIImageView.init()}()
    lazy var moreBtn = {UIButton.init(type: UIButtonType.system)}()
    lazy var arrowBtn = {UIButton.init(type:UIButtonType.system)}()
    lazy var sepLineLabel = {UILabel.init()}()

    weak var delegate: HomeHeaderViewDelegate?
    
    var total: Int? {
        didSet{
            if total! <= 4 {
                moreBtn.isHidden = true
                arrowBtn.isHidden = true
            } else {
                moreBtn.isHidden = false
                arrowBtn.isHidden = false
            }
        }
    }
    
    var isNeedSepLine:Bool? {
        didSet {
            if isNeedSepLine! {
                sepLineLabel.backgroundColor = UIColor.init(gray: 154)
                sepLineLabel.isHidden = false
            } else {
                sepLineLabel.isHidden = true
            }
        }
    }
    
    var headerViewModel:HeaderViewModel? {
        didSet {
            titleLabel.text = headerViewModel?.text
            iconImageView.image = UIImage.init(named: (headerViewModel?.icon)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerBoxView)
        self.headerBoxView.addSubview(titleLabel)
        self.headerBoxView.addSubview(iconImageView)
        self.headerBoxView.addSubview(moreBtn)
        self.headerBoxView.addSubview(arrowBtn)
        self.headerBoxView.addSubview(sepLineLabel)
    }
    
    
    override func layoutSubviews() {
        headerBoxView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        iconImageView.snp.makeConstraints { (make) in
            make.leftMargin.topMargin.bottomMargin.equalTo(10)
            make.width.equalTo(headerBoxView.snp.height).offset(-20)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(iconImageView).offset(10)
            make.centerY.equalTo(headerBoxView)
            make.height.equalTo(headerBoxView)
            make.rightMargin.equalTo(moreBtn).offset(10)
        }
        moreBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.centerY.equalTo(self)
            make.rightMargin.equalTo(self).offset(10)
        }
        sepLineLabel.snp.makeConstraints { (make) in
            make.width.bottom.left.equalTo(headerBoxView)
            make.height.equalTo(0.5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
