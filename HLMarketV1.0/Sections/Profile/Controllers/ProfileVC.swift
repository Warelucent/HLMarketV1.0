//
//  ProfileVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import Alamofire

private let kProfileTableCellID = "kProfileTableCellID"
private let kProfileInfoLabelCellID = "kProfileInfoLabelCell"
private let kProfileCollectionCellID = "kProfileCollectionCell"


class ProfileVC: BaseViewController {
    
    lazy var profileTableView:UITableView = {[weak self] in
        let tableRect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kTabBarH)
        let tableview = UITableView.init(frame: tableRect, style: UITableViewStyle.grouped)
        
        tableview.showsVerticalScrollIndicator = false
        tableview.backgroundColor = UIColor.init(gray: 252)
        tableview.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        tableview.delegate = self
        tableview.dataSource  = self
        
        //MARK: 各种注册cell 
        /*
         该页面一共有三种cell, 两种headerView
        */
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:kProfileTableCellID)
        tableview.register(ProfileInfoLabelCell.self, forCellReuseIdentifier:kProfileInfoLabelCellID)
        tableview.register(ProfileCollectionCell.self, forCellReuseIdentifier: kProfileCollectionCellID)
        
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileTableView)
        self.view.backgroundColor = UIColor.init(gray: 252)
        
        let notificationName = Notification.Name(rawValue: "loginSucessNotification")
        NotificationCenter.default.addObserver(self,selector:#selector(successLogin(notification:)), name: notificationName, object: nil)
        
    }

    func successLogin(notification:NSNotification) {
        self.profileTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension ProfileVC:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 || indexPath.section == 2 {
            let cell:ProfileInfoLabelCell = tableView.dequeueReusableCell(withIdentifier: kProfileInfoLabelCellID, for: indexPath) as! ProfileInfoLabelCell
            let personalInfoArray = [("0", "收藏的商品"), ("1", "我的足迹")]
            let vipCardArray = [("0", "我的积分"), ("0", "会员福利")]
            cell.btnClickClosure = {(tag:Int?)->Void in
                //MARK: --- tag 值分别是123, 124, 125, 126 , 对应的是收藏商品, 我的足迹, 我的积分, 会员福利
                
                print("---\(tag!)")
                
                switch tag! {
                case 123:
                    let vc = GoodsCollectedVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    
                    break
                }
            }
            
            let textDic = ["personalInfoLabel":personalInfoArray, "vipCardLabel":vipCardArray]
            switch indexPath.section {
            case 0:
                cell.textArray = textDic["personalInfoLabel"]
            case 2:
                cell.textArray = textDic["vipCardLabel"]
            default:
                cell.textArray = nil
            }
            
            return cell
        } else if indexPath.section == 1 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: kProfileCollectionCellID) as! ProfileCollectionCell
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kProfileTableCellID)
            //定义cell的样式
            
            let listInfoArray = [("hlm_account_manage", "账号管理"), ("hlm_address", "收货地址"), ("hlm_upgrad", "如何升级")]
            
            cell?.imageView?.image = UIImage.init(named: listInfoArray[indexPath.row].0)
            cell?.textLabel?.text = listInfoArray[indexPath.row].1
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return 60
        } else if indexPath.section == 1 {
            return 80
        } else {
            return 44
        }
    }
    
    //Mark: 点击Cell进行的交互
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                //MARK: --- 点击这里应该跳转到用户管理页面
                
            } else if indexPath.row == 1 {
                //MARK: ---点击这里应该挑战到地址管理页面
                let addressVC = AddressManageVC()
                self.navigationController?.pushViewController(addressVC, animated: true)
            } else {
                //MARK: --- 点击这里应该跳转到如何设计页面
            }
            
        }
    }
    
  
    //-------------------- 定义headerView的大小和样式
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return (kNavigationBarH + kStatusBarH) * 2
        case 3:
            return 0
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 || section == 2 {
            let headerRect = CGRect(x: 0, y: 0, width: kScreenW, height: 40.0);
            let newheader = HomeHeaderView.init(frame: headerRect)
            let textArray = ["我的订单", "我的会员卡"]
            newheader.headerViewModel = HeaderViewModel.init(dict: ["text": textArray[section - 1]])
            newheader.isNeedSepLine = true
            newheader.backgroundColor = UIColor.white
        
            
            
            return newheader
        } else if section == 0 {
            let headerRect = CGRect(x: 0, y: 0, width: kScreenW, height: (kNavigationBarH + kStatusBarH) * 2)
            let headerView = ProfileHeaderView.init(frame: headerRect)
            headerView.loginCallBack = {[weak self] in
                let registerVC = LoginViewController()
                self?.navigationController?.pushViewController(registerVC, animated: true)
            }
            headerView.uploadPicCallBack = {[weak self] in
                self?.uploadPicAction()
            }
            return headerView
        } else {
            return nil
        }
    }
    
    
    //--------------------  定义 footerView的大小和样式
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerRect = CGRect(x: 0, y: 0, width: kScreenW, height: 20.0)
        let footerView = UIView.init(frame: footerRect)
        
        let toplabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.5))
        let botlabel = UILabel.init(frame: CGRect(x: 0, y: 19, width: kScreenW, height: 0.5))
        footerView.addSubview(toplabel)
        if section != 3 {
            footerView.addSubview(botlabel)
        }
        toplabel.backgroundColor = UIColor.init(gray: 210)
        botlabel.backgroundColor = UIColor.init(gray: 210)
        return footerView
    }
    
}


//MARK: --- 实现ProfileCellectionViewcell Delegate

extension ProfileVC:ProfileCollectionCellDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("代理打印---[\(indexPath.section), \(indexPath.row)]")
        
        let titleArr = ["全部订单", "待付款", "待发货", "待收货", "已完成"]
        let index = indexPath.row
        var VC:BaseViewController?
        switch index {
        case 0:
            VC = AllOrdersVC()
        case 1:
            VC = UnpayOrdersVC()
        case 2:
            VC = UnpostOrdersVC()
        case 3:
            VC = UnrecevieOrdersVC()
        default:
            VC = FinishedOrdersVC()
        }
        
        if VC != nil {
            VC?.navigationItem.title = titleArr[index]
            self.navigationController?.pushViewController(VC!, animated: true)
        } else {
            return
        }
    }
}

//MARK: --- 上传图片控制

extension ProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func uploadPicAction() {
        let alertVC = UIAlertController.init(title: "上传图像", message: nil, preferredStyle: .actionSheet)
        
        let albumAction = UIAlertAction.init(title: "相机", style: .default) {
           (action:UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            } else {
                print("模拟其中无法打开照相机,请在真机中使用")
            }
           
        }
        
        let cameraAction = UIAlertAction.init(title: "相册", style: .default) {
            (action: UIAlertAction) -> Void in
           let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
           
        }
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertVC.addAction(albumAction)
        alertVC.addAction(cameraAction)
        alertVC.addAction(cancelAction)
        
        self.navigationController?.present(alertVC, animated: true, completion: { 
            
        })
        
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let homeDirectory = NSHomeDirectory()
            let documentPath = homeDirectory + "/Documents"
            print(documentPath)
            let fileManager = FileManager.default
            do {
                try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print(error)
            }
            let imageData = UIImagePNGRepresentation(image)
            let imagePath = documentPath+"/image.png"
            fileManager.createFile(atPath: imagePath, contents: imageData, attributes: nil)
            let filePath: String = String(format: "%@%@", documentPath, "/image.png")
            print("filePath:" + filePath)
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                //let lastData = NSData(contentsOfFile: filePath)
                multipartFormData.append(URL.init(fileURLWithPath: filePath), withName: "image")
            }, to: "http://zhaoqiuyang.xicp.net:35635/Simple_online/Upload_User_Image", encodingCompletion: { (result) in
                print(result)
            })
            
        }
        else {
        
        
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }

}












