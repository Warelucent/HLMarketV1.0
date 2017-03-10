//
//  CellCycleModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class CellCycleModel: NSObject {

    var text:String = ""
    var imageName:String = ""
    var unload_imageName = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
