//
//  AccountManageVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit


private let kAccountManageTableCellID = "kAccountManageTableCell"
class AccountManageVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        self.configureTableView()
        
        self.navigationItem.title = "账号管理"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "hlm_back_icon", highLightImage: "", size: CGSize(width:15, height:15), target: self, action: #selector(AccountManageVC.backAction))
    }
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func configureTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.init(gray: 252)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.5))
        view.backgroundColor = UIColor.init(gray:215)
        tableView.tableFooterView = view
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kAccountManageTableCellID)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAccountManageTableCellID, for: indexPath)

        let textArray = [("hlm_pay_pwd", "支付密码"), ("hlm_bind_phone", "绑定手机"), ("hlm_address", "收货地址"), ("hlm_upgrad", "如何升级")]
        cell.imageView?.image = UIImage.init(named: textArray[indexPath.row].0)
        cell.textLabel?.text  = textArray[indexPath.row].1
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
}
