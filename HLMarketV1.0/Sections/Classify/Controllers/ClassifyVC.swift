//
//  ClassifyVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

private let kClassifyTableViewCell = "kClassifyTableViewCell"
private let kClassifyTableViewCellHeight = 44


class ClassifyVC: BaseViewController {
    
    lazy var leftTableView:UITableView = {[weak self] in
        let rect = CGRect(x: 0, y: 0, width: kScreenW * (1 - 0.64), height: kScreenH - kTabBarH)
        let tableView = UITableView.init(frame: rect, style: UITableViewStyle.plain)
        
        //设定tableview的样式
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(ClassifyLeftTableCell.self, forCellReuseIdentifier: kClassifyTableViewCell)
        
        return tableView;
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 254)
        self.view.addSubview(leftTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}


extension ClassifyVC:UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kClassifyTableViewCell) as! ClassifyLeftTableCell
        cell.setRightLabelText("大白菜")
        cell.backgroundColor = UIColor.init(gray: 252)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(kClassifyTableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click:\(indexPath.row)")
        
    }
}

extension ClassifyVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.bounces = false
        } else if scrollView.contentOffset.y >= 0 {
            scrollView.bounces = true
        }
    }
}


