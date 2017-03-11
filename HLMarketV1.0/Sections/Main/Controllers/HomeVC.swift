//
//  HomeVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

private let kHomeItemMargin : CGFloat = 4
private let kItemW = (kScreenW - kItemMargin * 5) / 4
private let kItemH = 48
private let kHomeCellID = "kHomeCellID"
private let kHomeHeaderViewID = "kHomeHeaderViewID"


class HomeVC: BaseViewController, UIWebViewDelegate {
    
    lazy var webView: UIWebView = { [weak self] in
        let webView = UIWebView(frame: self!.view.frame)
        webView.scalesPageToFit = true
        webView.delegate = self
        self!.view.addSubview(webView)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let request = URLRequest(url: URL(string: "http://192.168.15.53:8080/Simple_online/lx")!)
        webView.loadRequest(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
}

// MARK: -- js响应函数
extension HomeVC {
    
    func fc(dataDic: Dictionary<String,String>) -> Void {
        
        let vc = ClassifyVC()
        vc.navigationItem.title = String.init(dataDic["typeName"]!)
        vc.typeDic = dataDic
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tejia(dataDic: Dictionary<String,String>) -> Void {
        print(dataDic)
    }
    
}

// MARK: -- UIWebViewDelegate
extension HomeVC {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let absolutePath = request.url!.absoluteString
        
        let scheme = "samson://"
        
        if absolutePath.hasPrefix(scheme) {
            
            let subPath = absolutePath.substring(from: scheme.endIndex)
            
            if subPath.contains("?") {//1个或多个参数
                
                let components = subPath.components(separatedBy: "?")
                
                let first = components.first!
                
                let firstComponents = first.components(separatedBy: "_")
                
                let methodName = firstComponents.first!
                
                var sel: Selector?
                
                if methodName == "tejia" {
                    sel = #selector(tejia)
                }else if methodName == "fc" {
                    sel = #selector(fc)
                }else {
                    return true
                }
                
                let last = components.last!
                
                let lastComponents = last.components(separatedBy: "&")
                
                var dataDic = Dictionary<String,String>()
                
                for (index,item) in lastComponents.enumerated() {
                    dataDic.updateValue(item.removingPercentEncoding!, forKey: firstComponents[index+1])
                }
                
                if self.responds(to: sel!) {
                    self.perform(sel!, with: dataDic)
                }
                
            }
//            else {//没有参数
//                
//                let methodName = subPath.replacingOccurrences(of: "_", with: ":")
//                
//                let sel = NSSelectorFromString(methodName)
//                
//                if self.responds(to: sel) {
//                    self.perform(sel)
//                }
//                
//            }
            
        }
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
    }
    
}



