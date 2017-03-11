//
//  GoodsDetailViewController.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/11.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kGoodsDetailViewCellID = "kGoodsDetailViewCellID"
private let kGoodsDetailViewCellID1 = "kGoodsDetailViewCellID1"
private let kSearchCellCollectionViewCellMargin:CGFloat = 8

class GoodsDetailViewController: BaseViewController {
    
    var cGoodsNo: String = ""
    var price: String = ""
    var vipPrice: String = ""
    
    fileprivate var backBtn: UIButton = {

        let btn = UIButton(frame: CGRect(x: 10 , y: 30, width: 44, height: 44))
        btn.setImage(UIImage.init(named: "hlm_back_icon"), for: UIControlState.normal)
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.sizeToFit()
//        btn.frame.size = CGSize(width: 15, height: 15)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-60), style: UITableViewStyle.plain)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.dataSource = self
        tableView.delegate   = self
        
        return tableView
    }()
    
    fileprivate lazy var bottomView: UIView = { [weak self] in
       
        let view = UIView(frame: CGRect(x: 0, y: self!.tableView.frame.maxY, width: kScreenW, height: 60))
        view.backgroundColor = UIColor.white
        
        let nameArr = ["客服","店铺","收藏"]
        let imageArr = ["hlm_service","hlm_shop","hlm_collect"]
        
        for i in 0..<3 {
            let btn = UIButton(frame: CGRect(x: 44*i, y: 0, width: 44, height: 60))
            btn.setTitle(nameArr[i], for: .normal)
            btn.setImage(UIImage.init(named: imageArr[i]), for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.tag = i+1
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            btn.contentHorizontalAlignment = .center
            btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView!.frame.size.height, -btn.imageView!.frame.size.width, 0, 0)
            btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel!.bounds.size.width-5, btn.titleLabel!.bounds.size.width/2, 0, 0)
            view.addSubview(btn)
        }
        
        let btn1 = UIButton(frame: CGRect(x: 44*3, y: 0, width: (kScreenW-44*3)/2, height: 60))
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn1.backgroundColor = UIColor.orange
        btn1.setTitle("加入购物车", for: .normal)
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn1.tag = 4
        btn1.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 44*3+(kScreenW-44*3)/2, y: 0, width: (kScreenW-44*3)/2, height: 60))
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("立即购买", for: .normal)
        btn2.setTitleColor(UIColor.white, for: .normal)
        btn2.tag = 5
        btn2.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
        view.addSubview(btn2)
        
        return view
        
    }()
    
    fileprivate var goodsModel: GoodsModel?
    fileprivate var dataArr1 = [Any]()
    fileprivate var dataArr2 = [GoodsTagModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        tableView.register(GoodsDetailTableViewCell.self, forCellReuseIdentifier: kGoodsDetailViewCellID)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kGoodsDetailViewCellID1)
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        
        self.view.addSubview(bottomView)
        
        self.view.addSubview(backBtn)

        getGoodsDetailDate(cGoodsNo: cGoodsNo)
        
    }
    
    // MARK: -- 获取数据
    func getGoodsDetailDate(cGoodsNo: String) -> Void {
        
        let parameters = ["cGoodsNo":cGoodsNo,"UserNo":"123"]
        
        AlamofireNetWork.required(urlString: "/Simple_online/Select_GoodsDetail", method: .post, parameters: parameters, success: { (result) in
            
            print(result)
            
            let json = JSON(result)
            
            if json["resultStatus"] == "1" {
                
                let arr = json["array"].arrayObject
                
//                let arr1 = json["array1"].arrayObject
                
                let arr2 = json["array2"].arrayObject
                
                self.goodsModel = GoodsModel.mj_object(withKeyValues: arr?[0])
                self.goodsModel?.cGoodsImagePath = "hlm_test_pic.jpg"
                self.goodsModel?.cGoodsNo = self.cGoodsNo
                self.goodsModel?.fNormalPrice = self.price
                self.goodsModel?.fVipPrice = self.vipPrice
                
                self.dataArr2 = GoodsTagModel.mj_objectArray(withKeyValuesArray: arr2) as! Array<GoodsTagModel>
                
                self.tableView.reloadData()
                
            }else {
                self.showHint(in: self.view, hint: "商品详情数据为空")
            }
            
        }) { (error) in
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: -- 按钮点击事件
extension GoodsDetailViewController {
    
    func btnAction(btn: UIButton) -> Void {
        print(btn.tag)
    }
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: -- UITableViewDelegate, UITableViewDataSource
extension GoodsDetailViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kGoodsDetailViewCellID, for: indexPath) as! GoodsDetailTableViewCell
            
            cell.goodsDetailModel = goodsModel
            
            cell.setgoodsTag(arr: dataArr2)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: kGoodsDetailViewCellID1, for: indexPath) 
            
            let label = UITextView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
            label.text = "        这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字这是一段商品介绍文字"
            label.isEditable = false
            label.font = UIFont.systemFont(ofSize: 12)
            
            cell.contentView.addSubview(label)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kScreenH/2
        }else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else{
            return 0
        }
    }
    
    //定义headerView的bounds和样式
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init()
        footerView.backgroundColor = UIColor.init(gray: 210)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init()
        headerView.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: 44))
        label.text = "商品介绍"
        
        let grayView = UIView(frame: CGRect(x: 0, y: 44, width: kScreenW, height: 1))
        grayView.backgroundColor = UIColor.init(gray: 210)
        
        headerView.addSubview(label)
        headerView.addSubview(grayView)
        
        return headerView
    }
}
// MARK: -- UINavigationControllerDelegate(隐藏、显示NavigationBar的动画)
extension GoodsDetailViewController:UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isHomePage = viewController.isKind(of: GoodsDetailViewController.self)
        self.navigationController?.setNavigationBarHidden(isHomePage, animated: true)
        
    }
}
