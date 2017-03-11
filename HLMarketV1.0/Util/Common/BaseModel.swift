//
//  BaseModel.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/10.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    override init() {
        super.init()
    }
    
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    //setValuesForKeysWithDictionary 字典转模型
    
    //setValue:forUndefinedKey:这个方法是关键,只有存在这个方法后,才可以过滤掉不存在的键值对而防止崩溃,同时,setValue:forUndefinedKey:这个方法中还可以改变系统的敏感字,或者,你手动的映射key值不同的值,随你自己喜欢
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
