//
//  UserAuthManager.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class UserAuthManager: NSObject {

    
    static let sharedManager = UserAuthManager()
    
    
//判断用户是否登录
    
    func isUserLogin() -> Bool {
        let usermodel = UserAuthManager.sharedManager.getUserModel()
        
        if usermodel == nil {
            return false
        } else {
            return true
        }
    }
    
//保存用户信息
    func saveUserInfo(userModel:UserAuthModel) {
        
    }
    
    
    
//获取用户信息
    
    func getUserModel() -> UserAuthModel? {
        let model = UserAuthModel.init(dict: [:])
        return model
    }
    
    
//清除用户信息
    func cleanUserInfo() {
        
    }
    
}
