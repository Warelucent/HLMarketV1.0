//
//  ProfileVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

private let kProfileTableCellID = "kProfileTableCellID"
private let kProfileInfoLabelCellID = "kProfileInfoLabelCell"
private let kProfileCollectionCellID = "kProfileCollectionCell"


class ProfileVC: BaseViewController {
    
    lazy var profileTableView:UITableView = {[weak self] in
        let tableRect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kTabBarH)
        let tableview = UITableView.init(frame: tableRect, style: UITableViewStyle.plain)
        
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
        
        
        let headerRect = CGRect(x: 0, y: 0, width: kScreenW, height: (kNavigationBarH + kStatusBarH) * 2)
        let headerView = ProfileHeaderView.init(frame: headerRect)
        tableview.tableHeaderView = headerView
        headerView.loginCallBack = {[weak self] in
            let registerVC = LoginViewController()
            self?.navigationController?.pushViewController(registerVC, animated: true)
        }
        return tableview
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileTableView)
        self.view.backgroundColor = UIColor.init(gray: 252)
        
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
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 || indexPath.section == 2 {
            let cell:ProfileInfoLabelCell = tableView.dequeueReusableCell(withIdentifier: kProfileInfoLabelCellID, for: indexPath) as! ProfileInfoLabelCell
            let personalInfoArray = [("0", "收藏的商品"), ("1", "我的足迹")]
            let vipCardArray = [("0", "我的积分"), ("0", "会员福利")]
            
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
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kProfileTableCellID)
            //定义cell的样式
            
            let listInfoArray = [("hlm_coupon", "我的优惠券"), ("hlm_integral_mall", "积分商城"), ("hlm_account_manage", "账号管理"), ("hlm_address", "收货地址"), ("hlm_upgrad", "如何升级")]
            
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
                let couponManageVC = CouponVC()
                self.navigationController?.pushViewController(couponManageVC, animated: true)
            } else if indexPath.row == 3 {
                let addressVC = AddressManageVC()
                self.navigationController?.pushViewController(addressVC, animated: true)
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //-------------------- 定义headerView的大小和样式
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
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
            return nil
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


