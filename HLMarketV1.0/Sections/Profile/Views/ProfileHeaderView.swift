//
//  ProfileHeaderView.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

typealias LoginCallBack = ()->Void

class ProfileHeaderView: UIView {

    
    var loginCallBack:LoginCallBack?
    
    lazy var iconImageView:UIImageView = { () -> UIImageView in
        let imageView = UIImageView.init()
        
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.init(gray: 252).cgColor
        imageView.layer.cornerRadius = 33
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var iconBtn:UIButton = { () -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        return btn
    }()
    
    lazy var editLoginBtn:UIButton = { () -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
    
        btn.backgroundColor = UIColor.clear
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.appMainColor().cgColor
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        
        btn.setTitleColor(UIColor.appMainColor(), for: UIControlState.normal)
        btn.setTitle("请登录使用", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        btn.addTarget(self, action: #selector(ProfileHeaderView.loginAction), for: UIControlEvents.touchUpInside)
        
        return btn
    }()
    
    
    func loginAction() {
        if loginCallBack != nil {
            loginCallBack!()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(iconBtn)
        self.addSubview(iconImageView)
        self.addSubview(editLoginBtn)
    }
    
    override func layoutSubviews() {
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(66)
            make.topMargin.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        editLoginBtn.snp.makeConstraints { (make) in
            make.width.equalTo(iconImageView).multipliedBy(1.2)
            make.height.equalTo(20)
            make.topMargin.equalTo(self.snp.bottom).offset(-38)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
