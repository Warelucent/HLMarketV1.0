
//
//  AllOrdersVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 12/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class AllOrdersVC: BaseViewController {
    
    lazy var pageTitleView:PageTitleView = { () -> PageTitleView in
        let pageTitleRect = CGRect(x: 0, y: 0, width: kScreenW, height: 46)
        let pageTitleView = PageTitleView.init(frame: pageTitleRect, titles: ["待付款", "待发货", "待收货", "已完成"])
        
        
        return pageTitleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(pageTitleView)
        pageTitleView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

}

extension AllOrdersVC:PageTitleViewDelegate {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int) {
        print("Click\(index)")
    }
}







