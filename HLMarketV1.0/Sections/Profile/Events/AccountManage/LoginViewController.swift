//
//  RegisterViewController.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: BaseViewController {

    
    
    //#warning  这个页面的约束有问题, 需要调整, 根据控制谈的提示, 是有多余的约束
    lazy var topBoxView = {UIView.init()}()
    
    lazy var userTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 20)
        let label = UILabel.init(frame:rect)
        label.text = "账号"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
    
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        //定义textfield的样式
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请输入用户名"
        textfield.font = UIFont.systemFont(ofSize: 12)
        textfield.clearButtonMode = UITextFieldViewMode.always
        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    
    lazy var pwdTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 20)
        let label = UILabel.init(frame:rect)
        label.text = "密码"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请输入密码"
        textfield.isSecureTextEntry = true
        textfield.clearButtonMode = UITextFieldViewMode.always
        textfield.font = UIFont.systemFont(ofSize: 12)
        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    
    lazy var botBoxView = {UIView.init()}()
    
    lazy var loginBtn = {() -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("登录", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.layer.borderColor = UIColor.init(r: 12, g: 205, b: 194).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.appMainColor().cgColor
        
        return btn
    }()
    
    lazy var forgotBtn = { ()-> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("忘记密码?", for: UIControlState.normal)
        btn.setTitleColor(UIColor.init(gray: 168), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
    
        return btn
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 252)
        
        self.navigationItem.title = "登录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "hlm_back_icon", highLightImage: "", size: CGSize(width:15, height:15), target: self, action: #selector(LoginViewController.backAction))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LoginViewController.registerAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //MARK: --- 登录按钮添加点击事件
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        self.setupUI()
        self.layoutUI()
    }
    
    
    func loginAction() {
        
        if userTF.text == nil || pwdTF.text == nil {
            showHint(in: view, hint: "用户名/密码不能为空")
        } else {
            
            AlamofireNetWork.required(urlString: "/Simple_online/User_Log_in", method: .post, parameters: ["UserNo":userTF.text!,"Pass":pwdTF.text!], success: { (results) in
                let json = JSON(results)
                print(json)
                if json["resultStatus"] == "1" {
                    let dictObj = json["dDate"].dictionaryObject
                    let userModel = UserAuthModel.init()
                    if dictObj?["UserNo"] != nil {
                        userModel.UserNo = dictObj?["UserNo"] as! String
                    }
                    if dictObj?["ImagePath"] != nil {
                        userModel.UserIcon = dictObj?["ImagePath"] as! String
                    }
                   UserAuthManager.sharedManager.saveUserInfo(userModel: userModel)
                    
                    DispatchQueue.main.async(execute: {
                        let vc = ProfileVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                
            }, failure: { (error) in
                print(error)
            })
        }
        
    }
    
    func registerAction() {
        
        if UserAuthManager.sharedManager.isUserLogin() {
            showHint(in: view, hint: "亲>已经登录啦!")
            return
        }
        
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    func setupUI() {
        view.addSubview(topBoxView)
        topBoxView.addSubview(userTF)
        topBoxView.addSubview(pwdTF)
        
        view.addSubview(botBoxView)
        botBoxView.addSubview(loginBtn)
        botBoxView.addSubview(forgotBtn)
        
    }
    
    func layoutUI() {
        
        topBoxView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(88)
        }
        
        userTF.snp.makeConstraints { (make) in
            make.top.left.equalTo(topBoxView).offset(5)
            make.height.equalTo(pwdTF)
            make.right.equalTo(-5)
            make.bottom.equalTo(pwdTF.snp.top).offset(-5)
        }
        
        pwdTF.snp.makeConstraints { (make) in
            //make.top.equalTo(userTF.snp.bottom).offset(5)
            make.bottom.equalTo(topBoxView.snp.bottom).offset(-5)
            make.left.right.equalTo(userTF)
            make.height.equalTo(userTF)
        }
        
        botBoxView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topBoxView)
            make.width.equalTo(topBoxView)
            make.top.equalTo(topBoxView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view).offset(-20)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(botBoxView)
            make.width.equalTo(botBoxView).multipliedBy(0.6)
            make.top.equalTo(botBoxView).offset(5)
            make.height.equalTo(userTF.snp.height)
        }
        
        forgotBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(2)
            make.right.equalTo(loginBtn.snp.right)
            make.height.equalTo(15)
            make.width.equalTo(40)
        }
        
    }
    
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
