
//
//  ShopCartSetmentView.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 11/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

typealias  InfoClosure = ()->(totalPrice:String, freight:String)
typealias  ClickVoidClosure = () -> Void

class ShopCartSetmentView: UIView {

    
    var setClickClosure:ClickVoidClosure?
    dynamic var isChecked:Bool  = false
    
    lazy var leftboxView = {UIView.init()}()
    lazy var rightBoxView = {UIView.init()}()
    
    lazy var checkBtn = {()->UIButton in
        let btn = UIButton.init(type:.system)
        btn.setImage(UIImage.init(named: "hlm_checkbox_nor")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(ShopCartSetmentView.chooseAllItems), for: .touchUpInside)
        return btn
    }()
    
    func chooseAllItems() {
        isChecked = !isChecked
        if isChecked {
             checkBtn.setImage(UIImage.init(named: "hlm_checkbox_select")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
             checkBtn.setImage(UIImage.init(named: "hlm_checkbox_nor")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    lazy var totalPriceLabel = { () -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(gray: 16)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    lazy var freightLabel = { () -> UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.init(gray: 16)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    lazy var setMentBtn = {() -> UIButton in
        let btn = UIButton.init(type:.system)
        btn.setTitle("结算", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.backgroundColor = UIColor.init(r: 252, g: 12, b: 12)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        return btn
    }()
    
    
   init(frame: CGRect, infoColosure:InfoClosure) {
        super.init(frame: frame)
        
        self.addSubview(leftboxView)
        self.addSubview(rightBoxView)
        self.leftboxView.addSubview(totalPriceLabel)
        //self.leftboxView.addSubview(freightLabel)
        self.leftboxView.addSubview(checkBtn)
        self.rightBoxView.addSubview(setMentBtn)
    
    setMentBtn.addTarget(self, action: #selector(clickForPayAction), for: .touchUpInside)
    self.totalPriceLabel.text = "合计:\(infoColosure().totalPrice)元"
    //self.freightLabel.text = "运费:\(infoColosure().freight)元"
    self.addObserver(self, forKeyPath: "isChecked", options: .new, context: nil)
    }
    
    func clickForPayAction() {
        if setClickClosure != nil {
            setClickClosure!()
        }
    }
    
    
    
    override func layoutSubviews() {
        leftboxView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(rightBoxView.snp.left)
        }
        
        checkBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
        }
        
        totalPriceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.left.equalTo(checkBtn.snp.right).offset(5)
            //make.top.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        /*
        freightLabel.snp.makeConstraints { (make) in
            make.width.right.height.equalTo(totalPriceLabel)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(5)
            
        }
        */
        rightBoxView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(leftboxView).multipliedBy(0.5)
        }
        
        setMentBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("122222222222222222222\(keyPath!)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(leftboxView)
        self.addSubview(rightBoxView)
        self.leftboxView.addSubview(totalPriceLabel)
        self.leftboxView.addSubview(freightLabel)
        self.leftboxView.addSubview(checkBtn)
        self.rightBoxView.addSubview(setMentBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
