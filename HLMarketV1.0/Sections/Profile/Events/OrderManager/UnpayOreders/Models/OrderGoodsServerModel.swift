
//
//  OrderGoodsServerModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 13/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class OrderGoodsServerModel: NSObject {

    var cGoodsNo = ""
    var cGoodsName = ""
    var Num = ""
    var Last_Price = ""
    var Last_Money = ""
    var cGoodsImagePath = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
