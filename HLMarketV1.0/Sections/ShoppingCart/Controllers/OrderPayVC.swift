//
//  OrderPayVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 12/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kOrderPayGoodsInfoCellID = "kOrderPayGoodsInfoCellID"
private let kOrderPayAdressCellID = "kOrderPayAdressCellID"

class OrderPayVC: BaseViewController {
    
    var selectedIndexs:[Int] = []
    var dataSource:[ShopCartServerModel] = []
    var totalMoney:Float = 0
    var addressModel:AddressUserModel?
    var freightCost:String?
    
    
    var totalMoneyLabel:UILabel?
    
    lazy var orderPayTableView:UITableView = {[weak self] in
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kTabBarH - kNavigationBarH - kStatusBarH)
        let tableView = UITableView.init(frame: rect, style: .plain)
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = BGCOLOR
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderPayGoodsInfoCell.self, forCellReuseIdentifier: kOrderPayGoodsInfoCellID)
        tableView.register(OrderPayAdressCell.self, forCellReuseIdentifier: kOrderPayAdressCellID)
        
        return tableView
        }()
    lazy var commitView = { () ->UIView in
        let view = UIView.init(frame:CGRect(x:0, y:kScreenH - kTabBarH - 20 - kNavigationBarH - kStatusBarH, width: kScreenW, height:20 + kTabBarH ))
        
        view.backgroundColor = UIColor.init(r:247,g:199,b:9)
        
        let label = UILabel.init()
        label.textAlignment = .right
        
        let btn = UIButton.init(type: .system)
        btn.setTitle("提交订单", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.backgroundColor = UIColor.init(r: 252, g: 12, b: 12)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        view.addSubview(label)
        view.addSubview(btn)
        
        btn.snp.makeConstraints({ (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        })
        label.snp.makeConstraints({ (make) in
            make.right.equalTo(btn.snp.left).offset(-15)
            make.centerY.equalTo(btn)
            make.left.equalToSuperview()
            make.height.equalToSuperview()
        })
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "订单确认"
        view.addSubview(orderPayTableView)
        view.addSubview(commitView)
        
        let userNo = UserAuthManager.sharedManager.getUserModel()?.UserNo
        
        //MARK: --- 第一次网络请求用于获取用户默认地址
        AlamofireNetWork.required(urlString: "/Simple_online/Request_Default_Address", method: .post, parameters: ["UserNo":userNo!], success: { (results) in
            print(results)
            let json = JSON(results)
            if json["resultStatus"] == "1" {
                let dictArr = json["dDate"].arrayObject
                if dictArr?.count == 0 {
                    return
                }
                let aDict:[String: Any] = dictArr![0] as! [String:Any]
                self.addressModel = AddressUserModel.init(dict: aDict)
                DispatchQueue.main.async(execute: {
                    self.orderPayTableView.reloadData()
                })
            }
        }) { (error) in
            print(error)
        }
        
        //MARK: --- 第二次网络请求用于获取运费
        AlamofireNetWork.required(urlString: "/Simple_online/Freight_Cost", method: .post, parameters: ["UserNo":userNo!, "Pass":"888.88"], success: { (results) in
                //let result:[String:Any] = results
                print(results)
            
                DispatchQueue.main.async(execute: {
                    self.orderPayTableView.reloadData()
                })
        }) { (error) in
            print(error)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension OrderPayVC:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            //MARK: --- 根据购物车里商品数量, 动态生成
            return self.selectedIndexs.count
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:OrderPayAdressCell = tableView.dequeueReusableCell(withIdentifier: kOrderPayAdressCellID, for: indexPath) as! OrderPayAdressCell
            cell.model = self.addressModel
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell:OrderPayGoodsInfoCell = tableView.dequeueReusableCell(withIdentifier: kOrderPayGoodsInfoCellID, for: indexPath) as! OrderPayGoodsInfoCell
            
            let modelPosition = self.selectedIndexs[indexPath.row]
            
            let servermodel = self.dataSource[modelPosition]

            let model = GoodsControlModel.init(dict: ["avtarImage":"hlm_test_pic.jpeg", "price":servermodel.Last_Price, "title":servermodel.cGoodsName, "count":servermodel.Num])
            cell.goodsControlView.model = model
            
            return cell
            
        } else if indexPath.section == 2{
            let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "orderPayCellID2")
            let infoArr = [("支付方式", "支付宝支付"), ("发票信息", "")]
            cell.textLabel?.text = infoArr[indexPath.row].0
            cell.detailTextLabel?.text = infoArr[indexPath.row].1
            cell.accessoryType = .disclosureIndicator
            return cell
            
        } else {
            let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "orderPayCellID2")
            let infoArr = [("商品总额", "3.80"), ("运费总额", "12.00")]
            cell.textLabel?.text = infoArr[indexPath.row].0
            cell.detailTextLabel?.text = infoArr[indexPath.row].1
            cell.detailTextLabel?.textColor = UIColor.red
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else if indexPath.section  == 1 {
            //MARK: --- 根据购物车里商品数量, 动态生成
            return 120
        } else {
            return 56
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let vc = ChooseAddressVC()
            vc.navigationItem.title = "选择收货地址"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
