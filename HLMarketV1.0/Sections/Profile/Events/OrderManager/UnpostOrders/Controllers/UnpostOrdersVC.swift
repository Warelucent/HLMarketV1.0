//
//  UnpostOrdersVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 12/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kUnPostOrdersVCTableViewCellID = "kUnPostOrdersVCTableViewCellID"

class UnpostOrdersVC: BaseViewController {

    var dataSource:[OrderSheetServerModel]? = []
    
    lazy var unpostTableView:UITableView = {[weak self] in
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        let tableView = UITableView.init(frame: rect, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = BGCOLOR
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UnpostOrderTableCell.self, forCellReuseIdentifier: kUnPostOrdersVCTableViewCellID)
        
        return tableView
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(unpostTableView)
        
        if let userNo = UserAuthManager.sharedManager.getUserModel()?.UserNo {
            AlamofireNetWork.required(urlString: "/Simple_online/Select_order", method: .post, parameters: ["UserNo":userNo, "fage":"0", "Number_of_pages":"1"], success: { (results) in
                print(results)
                let json = JSON(results)
                print(json)
                if json["resultStatus"] == "1" {
                    let dictArr = json["array"].arrayObject
                    if dictArr?.count == 0 {
                        return
                    }
                    for aDict in dictArr! {
                        let aDict:[String:Any] = aDict as! [String : Any]
                        let sheetModel = OrderSheetServerModel.init(dict: aDict)
                        self.dataSource?.append(sheetModel)
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.unpostTableView.reloadData()
                    })
                }
                
            }) { (error) in
                print(error)
            }
            
        } else {
            print("难道你走到这里了!!")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


extension UnpostOrdersVC:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.dataSource != nil {
            return (dataSource?.count)!
        } else {
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let deitailsArr = self.dataSource?[section]
        if let arr = deitailsArr {
            return arr.detailsModels.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UnpostOrderTableCell = tableView.dequeueReusableCell(withIdentifier: kUnPostOrdersVCTableViewCellID, for: indexPath) as! UnpostOrderTableCell
        let deitailsArr = self.dataSource?[indexPath.section]
        
        
        if let model = deitailsArr?.detailsModels[indexPath.row] {
            cell.subView.model = GoodsControlModel.init(dict: ["avtarImage":"hlm_test_pic.jpeg", "title":model.cGoodsName, "price":model.Last_Price, "count":model.Num])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        
        let seplabel = UILabel.init()
        seplabel.backgroundColor = UIColor.init(gray: 200)
        
        let titleLabel = UILabel.init()
        let goodsPrice = "3.50"
        let freight = "2.00"
        let goodsCount = "2"
        titleLabel.text = "共\(goodsCount)件商品  合计¥\(goodsPrice)(含运费¥\(freight))"
        titleLabel.textColor = UIColor.init(gray: 188)
        
        let connectBtn = createBtn(title: "联系卖家", bgColor: UIColor.white, borderColor: UIColor.init(gray: 232), titleColor: UIColor.black)
        
        let remindBtn = createBtn(title: "提醒发货", bgColor: UIColor.white, borderColor: UIColor.init(gray: 232), titleColor: UIColor.black)
        
        
        
        view.addSubview(connectBtn)
        view.addSubview(remindBtn)
        view.addSubview(seplabel)
        view.addSubview(titleLabel)
        //MARK: --- 布局
        seplabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-20)
        }
        
        remindBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(80)
        }
        connectBtn.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(remindBtn)
            make.right.equalTo(remindBtn.snp.left).offset(-15)
        }
        
        
        
        
        return view
    }
    
    func createBtn(title:String, bgColor:UIColor, borderColor:UIColor, titleColor:UIColor) -> UIButton {
        let btn = UIButton.init(type: .system)
        btn.layer.backgroundColor = bgColor.cgColor
        btn.layer.borderColor = borderColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle(title, for: .normal)
        return btn
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
