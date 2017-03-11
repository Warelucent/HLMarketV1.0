//
//  Constant.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

/// 归档路径
let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString


/// notification
let NotifyUpdateCategory = NSNotification.Name(rawValue:"notifyUpdateCategory")
let KSelectedChannel: String = "selectedChannel"

/// 常用属性
let DefaultURL = "http://192.168.15.53:8080"
let kItemMargin : CGFloat = 10
let kHeaderViewH : CGFloat = 50
let kNormalItemW = (kScreenW - 5 * kItemMargin) / 4
let kNormalItemH = kNormalItemW * 3 / 4
let NormalCellID = "NormalCellID"
let SearchCellID = "SearchCellID"
let HeaderViewID = "HeaderViewID"

let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 49
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let BGCOLOR: UIColor = UIColor(gray: 244)


/// 延迟执行
///
/// - Parameters:
///   - delay: 延迟时间
///   - blok: 延迟执行的闭包
func DispatchQueue_AfterExecute(delay:Double, blok:@escaping ()->()) {
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: blok)
    
}

/// 获取当前屏幕的视图控制器
///
/// - Returns: 返回viewController
func getCurrentVC()->UIViewController{
    
    var window = UIApplication.shared.keyWindow
    if window?.windowLevel != UIWindowLevelNormal{
        let windows = UIApplication.shared.windows
        for  tempwin in windows{
            if tempwin.windowLevel == UIWindowLevelNormal{
                window = tempwin
                break
            }
        }
    }
    let frontView = (window?.subviews)![0]
    let nextResponder = frontView.next
    if nextResponder?.isKind(of: UIViewController.self) == true{
        return nextResponder as! UIViewController
    }else if nextResponder?.isKind(of: UINavigationController.self) == true{
        return (nextResponder as! UINavigationController).visibleViewController!
    }else {
        
        if (window?.rootViewController) is UINavigationController{
            return ((window?.rootViewController) as! UINavigationController).visibleViewController!//只有这个是显示的controller 是可以的必须有nav才行
        }
        //        else if (window?.rootViewController) is BoosjTabBarViewController{
        //            return ((window?.rootViewController) as! UITabBarController).selectedViewController! //不行只是最三个开始的页面
        //        }
        
        return (window?.rootViewController)!
        
    }
    
}









