//
//  ShopCartStyleModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class ShopCartStyleModel: NSObject {

    var goodsAvtarView:String = ""
    var goodsTitle:String = ""
    var goodsPrice:String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
