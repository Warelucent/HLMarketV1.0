//
//  RegisterViewController.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit



class RegisterViewController: BaseViewController {
    
    
    lazy var topBoxView = {UIView.init()}()
    var verCode:String? = nil
    
    lazy var phoneTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 20)
        let label = UILabel.init(frame:rect)
        label.text = "手机号"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        //定义textfield的样式
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请输入手机号"
        textfield.font = UIFont.systemFont(ofSize: 12)
        textfield.clearButtonMode = UITextFieldViewMode.always
        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    // --- Q: 如何获取点击获取验证码的按钮, 让每次发送之后, 按钮禁用60s
    lazy var verCodeTF = {() -> UITextField in
        let textfield = UITextField.init()
        let rect = CGRect(x: 0, y: 0, width: 60, height: 20)
        let label = UILabel.init(frame:rect)
        label.text = "验证码"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        
        textfield.leftViewMode = UITextFieldViewMode.always
        textfield.leftView = label
        
        let rightBoxRect = CGRect(x: 0, y: kScreenW - 150, width: 120, height: 20)
        let rightBoxView = UIView.init(frame:rightBoxRect)
        let sepLine      = UIView.init(frame:CGRect(x: 0, y: 0, width: 0.5, height: 20))
        sepLine.backgroundColor = UIColor.init(gray: 212)
        
        let getCodeBtn   = UIButton.init(type: UIButtonType.system)
        getCodeBtn.setTitle("获取验证码", for: UIControlState.normal)
        getCodeBtn.setTitleColor(UIColor.init(gray:168), for: UIControlState.normal)
        getCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        //点击按钮获取验证码
        getCodeBtn.addTarget(self, action: #selector(RegisterViewController.getCodeAction), for: UIControlEvents.touchUpInside)
        
        getCodeBtn.frame = CGRect(x: 0, y: 0, width: 118, height: 20)
        //布局 ----- snp
        
        
        rightBoxView.addSubview(sepLine)
        rightBoxView.addSubview(getCodeBtn)
        
        textfield.rightView = rightBoxView
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.layer.borderColor = UIColor.init(gray: 234).cgColor
        textfield.layer.borderWidth = 1
        textfield.placeholder = "请输入验证码"
        textfield.clearButtonMode = UITextFieldViewMode.always
        textfield.font = UIFont.systemFont(ofSize: 12)
        
        
        textfield.backgroundColor = UIColor.white
        return textfield
    }()
    
    
    lazy var botBoxView = {UIView.init()}()
    
    lazy var nextStepBtn = {() -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("下一步", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        btn.addTarget(self, action: #selector(RegisterViewController.nextRegisterAction), for: UIControlEvents.touchUpInside)
        
        btn.layer.borderColor = UIColor.init(r: 12, g: 205, b: 194).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.appMainColor().cgColor
        
        return btn
    }()
    
    
    func getCodeAction() {
        do {
            let pattern = "^1[0-9]{10}$"
            let validateString = phoneTF.text!
            
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
            if matches.count > 0 {
                //进行网络请求, 发送验证码
                
                AlamofireNetWork.required(urlString: "/Simple_online/Get_TelPhone_Code", method: .post, parameters: ["Tel": validateString, "reg_or_update":"0"], success: { [weak self] (results) in
                    if results["resultStatus"] as! String == "000000" {
                        self?.showHint(in: (self?.view)!, hint: "验证码已发送, 请注意查收")
                        self?.verCode = results["dDate"] as! String?
                    }
                }, failure: { (error) in
                    print(error)
                })
                
            } else {
                showHint(in: view, hint: "请输入正确的手机号")
            }
        }
        catch {
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 252)
        
        self.navigationItem.title = "注册"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "hlm_back_icon", highLightImage: "", size: CGSize(width:15, height:15), target: self, action: #selector(RegisterViewController.backAction))
        self.setupUI()
        self.layoutUI()
    }
    
    func nextRegisterAction() {
        let text = verCodeTF.text
        if text! == self.verCode {
            let nextRegisterVC = NextRegisterVC()
            nextRegisterVC.tel = phoneTF.text!
            
            self.navigationController?.pushViewController(nextRegisterVC, animated: true)
            
            
        } else {
            showHint(in: self.view, hint: "验证码不正确")
        }
    }
    
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func setupUI() {
        view.addSubview(topBoxView)
        topBoxView.addSubview(phoneTF)
        topBoxView.addSubview(verCodeTF)
        
        view.addSubview(botBoxView)
        botBoxView.addSubview(nextStepBtn)
        
    }
    
    func layoutUI() {
        
        topBoxView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(88)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.top.left.equalTo(topBoxView).offset(5)
            make.height.equalTo(verCodeTF)
            make.right.equalTo(-5)
            make.bottom.equalTo(verCodeTF.snp.top).offset(-5)
        }
        
        verCodeTF.snp.makeConstraints { (make) in
            //make.top.equalTo(userTF.snp.bottom).offset(5)
            make.bottom.equalTo(topBoxView.snp.bottom).offset(-5)
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(phoneTF)
        }
        
        botBoxView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topBoxView)
            make.width.equalTo(topBoxView)
            make.top.equalTo(topBoxView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view).offset(-20)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(botBoxView)
            make.width.equalTo(botBoxView).multipliedBy(0.6)
            make.top.equalTo(botBoxView).offset(5)
            make.height.equalTo(phoneTF.snp.height)
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
