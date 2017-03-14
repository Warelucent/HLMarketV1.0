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
        cell.delegate = self
        if indexPath.row == selectedIndex {
            cell.isChoosed = true
        } else {
            cell.isChoosed = false
        }
        
        cell.clickDefaultBtnClosure = {(cellId:Int, sender:UIButton) in
            self.selectedIndex = cellId
            self.tableView.reloadData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension AddressManageVC:AddressManageViewCellDelegate {
    
    func deleteAdress(sender:UIButton, cellID:Int) {
        
        let alertVC = UIAlertController.init(title: "是否确定删除该地址", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction.init(title: "确定", style: .default) { (alertAction:UIAlertAction) in
            //1. 从本地数据源中删除数据
            self.userAddressModels?.remove(at: cellID)
            //2. 刷新视图
            self.tableView.deleteRows(at: [IndexPath.init(item: cellID, section: 0)], with: .left)
            self.tableView.reloadData()
            //3. 网络发送请求,说明该数据被删除
            // DispatchQueue.global().async(execute: {
                if let addressId = self.userAddressModels?[cellID].AddressID {
                
                    AlamofireNetWork.required(urlString: "/Simple_online/Delete_Address",method: .post,
                        parameters: ["AddressID":addressId],success: { (result) in
                            
                            let json = JSON(result)
                            if json["resultStatus"] == "1" {
                                self.showHint(in: self.view, hint: "删除成功")
                            }
                        },failure: { (error) in
                            print(error)
                        })
                    
                }
            //})
            
            
        }
        
        let  cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (alertAction:UIAlertAction) in
        }
        
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    func editAddress(sender:UIButton, cellID:Int) {
        
        if let userAddressModels = self.userAddressModels {
            let model = userAddressModels[cellID]
            
            let editAddressVC = EditAddressVC()
            editAddressVC.model = model
            self.navigationController?.pushViewController(editAddressVC, animated: true)
            
        }
        
        
        
        
        
        
    }
    
    
}



