//
//  AllExtension.swift
//  HLProcurementSwift
//
//  Created by 彭仁帅 on 2017/1/6.
//  Copyright © 2017年 PigPRS. All rights reserved.
//

import UIKit

// MARK: -- UIAlertController
extension UIAlertController {
    
    /// AlertContrller（不带Action）
    ///
    /// - Parameters:
    ///   - target: 视图控制器
    ///   - title: 标题
    ///   - message: 信息
    ///   - second: 几秒后消失
    class func show(target: AnyObject, title: String = "提示", message: String, second: Float = 2.5){
        
        let alertContrller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        target.present(alertContrller, animated: true, completion: nil)
        
        DispatchQueue_AfterExecute(delay:1, blok:{
            alertContrller.dismiss(animated: true, completion: nil)
        })
        
    }
    
    /// AlertContrller（带两个自定义的Action）
    ///
    /// - Parameters:
    ///   - target: 视图控制器
    ///   - type: 类型（默认：'alert'）
    ///   - alertAction1: 第一个自定义的Action
    ///   - alertAction2: 第二个自定义的Action
    ///   - title: 标题（默认：'提示'）
    ///   - message: 信息
    ///   - isHaveTextField: 是否有输入框（默认：false）
    class func showAction(target: AnyObject, type: UIAlertControllerStyle = .alert, alertAction1: UIAlertAction?, alertAction2: UIAlertAction?, title: String = "提示", message: String, isHaveTextField: Bool = false) -> UIAlertController{
        
        let alertContrller = UIAlertController.init(title: title, message: message, preferredStyle: type)
        
        if let action1 = alertAction1 {
            alertContrller.addAction(action1)
        }
        
        if let action2 = alertAction2 {
            alertContrller.addAction(action2)
        }
        
        if isHaveTextField == false {
            target.present(alertContrller, animated: true, completion: nil)
        }
        
        return alertContrller
        
    }
    
}





