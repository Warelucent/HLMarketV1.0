//
//  AddressManageVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kProfileAdressManageCellID = "kProfileAdressManageCellID"

class AddressManageVC: UITableViewController {

    var userAddressModels:[AddressUserModel]? = []
    var selectedIndex:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "hlm_back_icon", highLightImage: "", size: CGSize(width:20, height:20), target: self, action: #selector(AddressManageVC.backAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "hlm_add_new_address", highLightImage: "", size: CGSize(width:30, height:30), target: self, action: #selector(AddressManageVC.addAddressAction))
        self.navigationItem.title = "管理收货地址"
        
        tableView.backgroundColor = UIColor.init(gray: 232)
        tableView.separatorStyle  = UITableViewCellSeparatorStyle.none
        
        
        
        tableView.register(AddressManageViewCell.self, forCellReuseIdentifier: kProfileAdressManageCellID)
        
        
        if let userNo = UserAuthManager.sharedManager.getUserModel()?.UserNo {
            AlamofireNetWork.required(urlString: "/Simple_online/Select_User_Address", method: .post, parameters: ["UserNo":userNo], success: { (results) in
                let json = JSON(results)
                print(json)
                if json["resultStatus"] == "1" {
                    let dictArray = json["dDate"].arrayObject
                    for aDict in dictArray! {
                        let aDict:[String:Any] = aDict as! [String : Any]
                        let model = AddressUserModel.init(dict: aDict)
                        self.userAddressModels?.append(model)
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
            }) { (error) in
                print(error)
            }
        }
    }
    
    //MARK: 新增收货地址
    func addAddressAction() {
        let addNewAdressVC = AddNewAdressVC()
        self.navigationController?.pushViewController(addNewAdressVC, animated: true)
    }
    
    
    func backAction() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.userAddressModels == nil {
            return 0
        }
        return (self.userAddressModels?.count)!
    }

    var btnsManager:[(index:Int, model:AddressUserModel, isChoosed:Bool)]{
        get {
            var manager:[(Int, AddressUserModel, Bool)] = []
            for (index, item) in (userAddressModels?.enumerated())! {
                let item = item
                manager.append((index, item, false))
            }
             return manager
        }
    }
    
    
    func manageBtnState(defaultID:Int) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AddressManageViewCell = tableView.dequeueReusableCell(withIdentifier: kProfileAdressManageCellID, for: indexPath) as! AddressManageViewCell
        cell.addressUserModel = userAddressModels?[indexPath.row]
        cell.cellID = indexPath.row
        
        if indexPath.row == selectedIndex {
            cell.isChoosed = true
        } else {
            cell.isChoosed = false
        }
        
        cell.clickDefaultBtnClosure = {(cellId:Int, sender:UIButton) in
            
            print("你点击了位置在:\(cellId)的btn")
            self.selectedIndex = cellId
            /*
            for i in 0..<self.userAddressModels!.count {
                let theIndexPath = IndexPath.init(row: i, section: indexPath.section)
                let cell:AddressManageViewCell = tableView.dequeueReusableCell(withIdentifier: kProfileAdressManageCellID, for: theIndexPath) as! AddressManageViewCell
                cell.addressUserModel = self.userAddressModels?[indexPath.row]
                cell.cellID = indexPath.row
                if i == cellId {
                    cell.isChoosed = true
                } else {
                    cell.isChoosed = false
                }
            }
            self.tableView.reloadData()
            */
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:AddressManageViewCell = tableView.dequeueReusableCell(withIdentifier: kProfileAdressManageCellID, for: indexPath) as! AddressManageViewCell
        if let state = cell.isChoosed {
            print("\(indexPath.row)---------\(state)")
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
