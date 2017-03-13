//
//  GoodsCollectedVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 12/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class GoodsCollectedVC: UITableViewController {

    var dataSource:[Any]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        self.navigationItem.title = "收藏商品"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "reuseCellID")
        cell.imageView?.image = UIImage.init(named: "hlm_test_pic")
        cell.textLabel?.text = "大白菜"
        cell.detailTextLabel?.text = "3.8"
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
    }

   
}
