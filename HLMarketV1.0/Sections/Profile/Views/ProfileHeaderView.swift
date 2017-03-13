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
    var uploadPicCallBack:LoginCallBack?
    
    lazy var iconImageView:UIImageView = { () -> UIImageView in
        let imageView = UIImageView.init()
        
        imageView.image = UIImage.init(named: "hlm_user_defalutavtar")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.appMainColor().cgColor
        imageView.layer.cornerRadius = 33
        imageView.layer.masksToBounds = true

        
        return imageView
    }()
    
    lazy var iconBtn:UIButton = { () -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setImage(UIImage.init(named:"hlm_upload_pic"), for: .normal)
        //btn.layer.cornerRadius = 10
        //btn.layer.masksToBounds = true
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
    
    lazy var nameLabel = {()->UILabel in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    
    func loginAction() {
        if loginCallBack != nil {
            loginCallBack!()
        }
    }
    func uploadPicAction() {
        if uploadPicCallBack != nil {
            uploadPicCallBack!()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    
        self.addSubview(iconImageView)
        self.addSubview(iconBtn)
        
        
        iconBtn.addTarget(self, action: #selector(uploadPicAction), for: .touchUpInside)
        if UserAuthManager.sharedManager.isUserLogin() {
            self.addSubview(nameLabel)
            let model = UserAuthManager.sharedManager.getUserModel()
            if model?.UserName == "" {
                nameLabel.text = "暂无昵称"
            } else {
                nameLabel.text = model?.UserName
            }
        } else {
            self.addSubview(editLoginBtn)
        }
        
        //MARK: --- 上传图片功能按钮
        
    }
    
    
    
    
    override func layoutSubviews() {
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(66)
            make.topMargin.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        iconBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImageView.snp.bottom).offset(-5)
            make.right.equalTo(iconImageView.snp.right).offset(-5)
            make.height.width.equalTo(20)
        }
        
        if UserAuthManager.sharedManager.isUserLogin() {
            nameLabel.snp.makeConstraints { (make) in
                make.width.equalTo(iconImageView).multipliedBy(1.2)
                make.height.equalTo(20)
                make.topMargin.equalTo(self.snp.bottom).offset(-38)
                make.centerX.equalToSuperview()
            }

        } else {
            editLoginBtn.snp.makeConstraints { (make) in
                make.width.equalTo(iconImageView).multipliedBy(1.2)
                make.height.equalTo(20)
                make.topMargin.equalTo(self.snp.bottom).offset(-38)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
