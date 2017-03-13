//
//  NextRegisterVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class NextRegisterVC: BaseViewController {

    lazy var topBoxView = {UIView.init()}()
    
    var tel:String? = nil
    
    lazy var pwdTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 30)
        let label = UILabel.init(frame:rect)
        label.text = "密码"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        //定义textfield的样式
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请输入密码"
        textfield.font = UIFont.systemFont(ofSize: 12)
        textfield.clearButtonMode = UITextFieldViewMode.always
        textfield.isSecureTextEntry = true

        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    
    lazy var confirmPwdTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 30)
        let label = UILabel.init(frame:rect)
        label.text = "确认密码"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请再次输入密码"
        textfield.isSecureTextEntry = true
        textfield.clearButtonMode = UITextFieldViewMode.always
        textfield.font = UIFont.systemFont(ofSize: 12)
        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    
    lazy var botBoxView = {UIView.init()}()
    
    lazy var registerBtn = {() -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("注册", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        btn.layer.borderColor = UIColor.init(r: 12, g: 205, b: 194).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.appMainColor().cgColor
        
        return btn
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 252)
        
        self.navigationItem.title = "密码设置"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "hlm_back_icon", highLightImage: "", size: CGSize(width:15, height:15), target: self, action: #selector(NextRegisterVC.backAction))
        self.registerBtn.addTarget(self, action: #selector(NextRegisterVC.registerAction), for: .touchUpInside)
        
        self.setupUI()
        self.layoutUI()
    }

    func registerAction() {
        if pwdTF.text == nil || confirmPwdTF.text == nil {
            showHint(in: view, hint: "密码不能为空")
            return
        }
        
        if pwdTF.text != confirmPwdTF.text {
            showHint(in: view, hint: "密码不一致!")
            return
        }
        
        do {
            let pattern = "^[A-Z0-9a-z]{6,18}"
            let validateString = pwdTF.text!
            
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
            if matches.count > 0 {
                //网络请求, 进行注册
                AlamofireNetWork.required(urlString: "/Simple_online/User_Register", method: .post, parameters: ["Tel":self.tel!, "PassWord":pwdTF.text!], success: { (results) in
                    print(results)
                }, failure: { (error) in
                    print(error)
                })
                
                
            } else {
                showHint(in: view, hint: "密码强度过低!")
                return
            }
        }
        catch {
            
        }
    
        
    }
    
    func setupUI() {
        view.addSubview(topBoxView)
        topBoxView.addSubview(pwdTF)
        topBoxView.addSubview(confirmPwdTF)
        
        view.addSubview(botBoxView)
        botBoxView.addSubview(registerBtn)
        
    }
    
    func layoutUI() {
        
        topBoxView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(88)
        }
        
        pwdTF.snp.makeConstraints { (make) in
            make.top.left.equalTo(topBoxView).offset(5)
            make.height.equalTo(confirmPwdTF)
            make.right.equalTo(-5)
            make.bottom.equalTo(confirmPwdTF.snp.top).offset(-5)
        }
        
        confirmPwdTF.snp.makeConstraints { (make) in
            //make.top.equalTo(userTF.snp.bottom).offset(5)
            make.bottom.equalTo(topBoxView.snp.bottom).offset(-5)
            make.left.right.equalTo(pwdTF)
            make.height.equalTo(pwdTF)
        }
        
        botBoxView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topBoxView)
            make.width.equalTo(topBoxView)
            make.top.equalTo(topBoxView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view).offset(-20)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(botBoxView)
            make.width.equalTo(botBoxView).multipliedBy(0.6)
            make.top.equalTo(botBoxView).offset(5)
            make.height.equalTo(pwdTF.snp.height)
        }
        
        
    }
    
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}
