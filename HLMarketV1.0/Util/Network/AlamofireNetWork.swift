//
//  AlamofireNetWork.swift
//  HLProcurementSwift
//
//  Created by 彭仁帅 on 2017/1/9.
//  Copyright © 2017年 PigPRS. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireNetWork {
    
    class func required(urlString: String, method: HTTPMethod, parameters: [String:String]?, success: @escaping ([String: Any]) -> (), failure: ((Error) -> ())?) -> Void {
        
        let url: String = DefaultURL + urlString
        
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: Any] {
                    success(value)
                }
                break
            case .failure(let error):
                
                if let failures = failure {
                    failures(error)
                }
                break
            }
            
        }
        
    }

}
