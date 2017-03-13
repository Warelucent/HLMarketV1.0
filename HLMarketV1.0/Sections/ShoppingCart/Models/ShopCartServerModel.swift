//
//  ShopCartServerModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 13/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class ShopCartServerModel: NSObject {
    var Date_time:String = ""
    var Last_Price:String = ""
    var Num = ""
    var RowNumber = "10"
    var cGoodsImagePath = ""
    var cGoodsName = ""
    var cGoodsNo = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    
}
