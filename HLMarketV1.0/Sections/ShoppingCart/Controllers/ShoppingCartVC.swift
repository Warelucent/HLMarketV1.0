//
//  ShoppingCartVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON


private let kSettlementViewHeight:CGFloat = 49
private let kShoppingCartTableViewCellID = "kShoppingCartTableViewCellID"
class ShoppingCartVC: BaseViewController {

    var dataSource:[ShopCartServerModel] = []
    var setCheckBtn:UIButton?
    var isSetChecked:Bool = false
    

    
    lazy var tableView:UITableView = {[weak self] in
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kTabBarH - kSettlementViewHeight - kStatusBarH)
        let tableview = UITableView.init(frame: rect, style: .plain)
        
        tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = BGCOLOR
        
        tableview.register(ShopCartVCTableCell.self, forCellReuseIdentifier: kShoppingCartTableViewCellID)
        return tableview
    }()
    
    lazy var settlementView:UIView = {[weak self]() -> UIView in
        //下部父视图
        let rect = CGRect(x: 0, y: kScreenH - kTabBarH - kSettlementViewHeight - kNavigationBarH - kStatusBarH, width: kScreenW, height: kSettlementViewHeight)
        let view = UIView.init(frame:rect)
        view.backgroundColor = UIColor.init(r:247,g:199,b:9)
        
        let subView = ShopCartSetmentView.init(frame: view.bounds, infoColosure: { () -> (totalPrice: String, freight: String) in
            return ("59.00", "12.00")
        })
        subView.setClickClosure = {()->Void in
            let vc = OrderPayVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        view.addSubview(subView)
        
        return view
    }()
    
    func changeState() {
        if self.setCheckBtn != nil {
            if isSetChecked {
                setCheckBtn?.setImage(UIImage.init(named: "hlm_checkbox_select")?.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                setCheckBtn?.setImage(UIImage.init(named: "hlm_checkbox_nor")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            isSetChecked = !isSetChecked
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //右侧编辑按钮 --- 实现商品的收藏以及删除
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(ShoppingCartVC.operateShopCart))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes({[
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Heiti SC", size: 12.0)!
            ]}(), for: .normal)
        
//        if dataSource?.count == nil {
//            self.emptyCartInfoView()
//        }
//        else {
            self.view.addSubview(tableView)
            self.view.addSubview(settlementView)
//        }
        if let userNo = UserAuthManager.sharedManager.getUserModel()?.UserNo {
            AlamofireNetWork.required(urlString: "/Simple_online/Select_Shop_cart", method: .post, parameters: ["UserNo":userNo, "Number_of_pages":"1"], success: { (results) in
                print(results)
                let json = JSON(results)
                if json["resultStatus"] == "1" {
                    let dictArray = json["dDate"].arrayObject
                    for aDict in dictArray! {
                        let aDict:[String:Any] = aDict as! [String : Any]
                        let model = ShopCartServerModel.init(dict: aDict)
                        self.dataSource.append(model)
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
    func operateShopCart() {
        //点击按钮对cell进行处理
    }
    
    
    
    func emptyCartInfoView() {
        let imageview = UIImageView.init(image: UIImage.init(named: "empty_shopcart_girl"))
        let shopBtn = UIButton.init(type: .system)
        shopBtn.setTitle("去购物", for: .normal)
        shopBtn.setTitleColor(UIColor.white, for: .normal)
        
        shopBtn.layer.borderColor = UIColor.init(r: 12, g: 205, b: 194).cgColor
        shopBtn.layer.borderWidth = 1
        shopBtn.layer.cornerRadius = 5
        shopBtn.layer.masksToBounds = true
        shopBtn.layer.backgroundColor = UIColor.appMainColor().cgColor
        
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.init(gray: 200)
        titleLabel.text = "购物车没有商品"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(imageview)
        self.view.addSubview(shopBtn)
        self.view.addSubview(titleLabel)
        //布局
        let ratio = CGFloat(840/746)
        imageview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.618)
            make.width.equalToSuperview().multipliedBy(0.618)
            make.height.equalTo(imageview.snp.width).multipliedBy(ratio)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageview.snp.bottom).offset(10)
            make.width.equalTo(imageview).dividedBy(2)
            make.height.equalTo(shopBtn.snp.width).dividedBy(3)
        }
        shopBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(imageview).dividedBy(2)
            make.height.equalTo(shopBtn.snp.width).dividedBy(3)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
//MARK: --- Vaule

extension ShoppingCartVC:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ShopCartVCTableCell = tableView.dequeueReusableCell(withIdentifier: kShoppingCartTableViewCellID, for: indexPath) as! ShopCartVCTableCell
       
        let serverModel = dataSource[indexPath.row]
        
        cell.model = ShopCartGoodModel.init(dict: ["name":serverModel.cGoodsName, "price":serverModel.Last_Price, "avtarImage":"hlm_test_pic.jpg", "count":serverModel.Num, "isSelected": false])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}













