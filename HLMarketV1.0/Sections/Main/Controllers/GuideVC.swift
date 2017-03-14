//
//  GuideVC.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/14.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

class GuideVC: BaseViewController, UIScrollViewDelegate {
    
    var scrollerView = UIScrollView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollerView = UIScrollView(frame: view.frame)
        scrollerView.delegate = self
        scrollerView.isPagingEnabled = true
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.bounces = false
        view.addSubview(scrollerView)
        
        let imageArr = [#imageLiteral(resourceName: "hlm_guide_01"),#imageLiteral(resourceName: "hlm_guide_02")]
        
        for i in 0..<imageArr.count {
            
            let imageView = UIImageView(image: imageArr[i])
            imageView.frame = CGRect(x: kScreenW*CGFloat(i), y: 0, width: kScreenW, height: kScreenH)
            scrollerView.addSubview(imageView)
            
        }
        
        scrollerView.contentSize = CGSize(width: kScreenW*CGFloat(imageArr.count), height: kScreenH)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: kScreenW*(CGFloat(imageArr.count))-120, y: kScreenH*0.91, width: 100, height: 38)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.titleLabel?.font = font(14)
        btn.setTitle("开启购物之旅", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        scrollerView.addSubview(btn)
        
    }
    
    func btnAction() -> Void {
        let vc = TabBarController()
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
