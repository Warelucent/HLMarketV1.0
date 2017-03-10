
//
//  UserAuthModel.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 10/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class UserAuthModel: NSObject {

    var UserNo :  String = ""
    var Email  :  String = ""
    var UserPass: String = ""
    var UserName: String = ""
    var UserIcon: String = ""
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
