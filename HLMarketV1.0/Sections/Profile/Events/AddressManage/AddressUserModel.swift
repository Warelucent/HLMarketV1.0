



//
//  AddressUserModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 11/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class AddressUserModel: NSObject {

    var AddressID:String = ""
    var Available:String = ""
    var City:String = ""
    var Default_fage:String = ""
    var Detailaddress:String = ""
    var District:String = ""
    var Provincial:String = ""
    var Tel:String = ""
    var UserName:String = ""
    var UserNo:String = ""

    //MARK: --- 计算属性,获取用户地址的全部信息
    var UserTotalAdressInfo:String? {
        get {
            return Provincial + City + District + Detailaddress
        }
    }
    var UserMainAdressInfo:String? {
        get {
            return Provincial + City + District
        }
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
