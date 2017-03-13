
//
//  OrderSheetServerModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 13/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class OrderSheetServerModel: NSObject {
    var cSheetno = ""
    var Date_time = ""
    var detailsModels:[OrderGoodsServerModel] = []
    var user_addressModel:AddressUserModel?
    
    init(dict:[String:Any]) {
        super.init()
        for (key, value) in dict {
            if key == "details" {
                let newdictArr = value as! Array<Any>
                for aDict in newdictArr {
                    detailsModels.append(OrderGoodsServerModel.init(dict: aDict as! [String : Any]))
                }
            } else if key == "user_address" {
                let model = AddressUserModel.init(dict: value as! [String : Any])
                self.user_addressModel = model
            } else {
                setValuesForKeys([key : value])
            }
        }
        
        // setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
