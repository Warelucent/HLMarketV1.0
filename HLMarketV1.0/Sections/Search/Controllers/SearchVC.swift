//
//  SearchVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

private let kSearchTableViewCellID = "kSearchTableViewCellID"
private let kSearchCellCollectionViewCellID = "kSearchCellCollectionViewCellID"
private let kSearchCellCollectionViewCellMargin:CGFloat = 8


class SearchVC: BaseViewController {

    
    lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView.init(frame: (self?.view.bounds)!, style: UITableViewStyle.plain)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.dataSource = self
        tableView.delegate   = self
        
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kSearchTableViewCellID)
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSearchTableViewCellID, for: indexPath)
        
        
        //在cell上创建一个collectionView
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (kScreenW - 3 * kSearchCellCollectionViewCellMargin)/2.0
        let size = CGSize(width:itemWidth, height:itemWidth*1.5)
        layout.itemSize = size
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let colView = UICollectionView(frame: cell.bounds, collectionViewLayout:layout)
        
        
        colView.dataSource = self
        colView.dataSource = self
        colView.register(ShopCartStyleCell.self, forCellWithReuseIdentifier: kSearchCellCollectionViewCellID)
        colView.backgroundColor = UIColor.white
        
        cell.addSubview(colView)
        return cell
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return kScreenH - kTabBarH  - 70 - kStatusBarH - kNavigationBarH
    }
    
    //定义headerView的bounds和样式
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init()
        headerView.backgroundColor = UIColor.white
        
        let topBoxView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        topBoxView.backgroundColor = UIColor.init(gray: 252)
        let keywordTextField = UITextField.init(frame: CGRect(x: 5, y: 5, width: kScreenW - 80, height: 30))
        keywordTextField.backgroundColor = UIColor.white
        keywordTextField.layer.borderColor = UIColor.init(gray: 221).cgColor
        keywordTextField.layer.borderWidth = 1
        keywordTextField.layer.cornerRadius = 5
        keywordTextField.layer.masksToBounds = true
        
        
        
        let searchBtn = UIButton(type: UIButtonType.system)
        searchBtn.frame = CGRect(x: kScreenW - 70, y: 5, width: 65, height: 30)
        searchBtn.setTitle("搜索", for: UIControlState.normal)
        searchBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        searchBtn.layer.backgroundColor = UIColor.appMainColor().cgColor
        searchBtn.layer.borderWidth = 1
        searchBtn.layer.borderColor = UIColor.init(r: 6, g: 218, b: 210).cgColor
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.masksToBounds = true
        
        
        topBoxView.addSubview(keywordTextField)
        topBoxView.addSubview(searchBtn)
        
        
        let botPageRect = CGRect(x: 0, y: 40, width: kScreenW, height: 30)
        let botPageView = PageTitleView.init(frame: botPageRect, titles: ["默认", "价格", "数量", "浏览数"])
        
        
        
        headerView.addSubview(topBoxView)
        headerView.addSubview(botPageView)
        
        return headerView
    }
    
    
    
    //定义footerView的大小和样式
}

//?: 为什么延展里不能遵守layout协议
extension SearchVC:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShopCartStyleCell = collectionView.dequeueReusableCell(withReuseIdentifier: kSearchCellCollectionViewCellID, for: indexPath) as! ShopCartStyleCell
        
        cell.backgroundColor = UIColor.white
        
        cell.layer.borderColor = UIColor.init(gray: 246).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        //cell.layer.shadowOpacity = 0.8
        //cell.layer.shadowColor = UIColor.black.cgColor
        //cell.layer.shadowOffset = CGSize(width:1, height:1)
        
        let model:ShopCartStyleModel = ShopCartStyleModel.init(dict: ["goodsAvtarView":"hlm_test_pic.jpg)", "goodsPrice":"$:21.0", "goodsTitle":"苹果"])
        cell.shopCartModel = model
        return cell
    }
    
    
    
}




















