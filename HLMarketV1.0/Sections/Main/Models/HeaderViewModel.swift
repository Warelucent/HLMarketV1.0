//
//  HeaderViewModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class HeaderViewModel: NSObject {

    var ename: String = ""
    var text:  String = ""
    var icon:  String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
