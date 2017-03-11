//
//  SearchVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kSearchTableViewCellID = "kSearchTableViewCellID"
private let kSearchCellCollectionViewCellID = "kSearchCellCollectionViewCellID"
private let kSearchCellCollectionViewCellMargin:CGFloat = 8


class SearchVC: BaseViewController, PageTitleViewDelegate {

    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView.init(frame: (self?.view.bounds)!, style: UITableViewStyle.plain)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.dataSource = self
        tableView.delegate   = self
        
        
        return tableView
    }()
    
    fileprivate var keywordTextField = UITextField()
    
    fileprivate var botPageView: PageTitleView?
    
    fileprivate var colView: UICollectionView?
    
    fileprivate var dataArr = Array<ShopCartStyleModel>()
    
    fileprivate var currentType: Int = 1
    
    fileprivate var currentPage = 1
    
    fileprivate var isLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kSearchTableViewCellID)
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        
        getSearchDate(type: currentType, fage: "0", pages: currentPage)
        
    }
    
    // MARK: -- 获取数据
    func getSearchDate(type: Int, fage: String, pages: Int) -> Void {
        
        let parameters = ["Sort_type":"\(type)","fage":fage,"Number_of_pages":"\(pages)"]
        
        AlamofireNetWork.required(urlString: "/Simple_online/Select_Search_Goods", method: .post, parameters: parameters, success: { (result) in
            
            print(result)
            
            let json = JSON(result)
            
            if json["resultStatus"] == "1" {
                
                let data = json["dDate"].arrayObject
                
                let modelArr = ShopCartStyleModel.mj_objectArray(withKeyValuesArray: data) as! Array<ShopCartStyleModel>
                
                self.dataArr = self.dataArr + modelArr
                
                self.colView?.reloadData()
                
                self.isLoad = true
                
            }else {
//                self.showHint(in: self.view, hint: "类别为空")
                self.isLoad = false
                self.currentPage -= 1
            }
            
        }) { (error) in
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: -- UITableViewDelegate, UITableViewDataSource
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
        
        colView = UICollectionView(frame: cell.bounds, collectionViewLayout:layout)
        
        
        colView!.delegate = self
        colView!.dataSource = self
        colView!.register(ShopCartStyleCell.self, forCellWithReuseIdentifier: kSearchCellCollectionViewCellID)
        colView!.backgroundColor = UIColor.white
        
        cell.addSubview(colView!)
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
        keywordTextField = UITextField.init(frame: CGRect(x: 5, y: 5, width: kScreenW - 80, height: 30))
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
        searchBtn.addTarget(self, action: #selector(searchBtnAction), for: .touchUpInside)
        
        
        topBoxView.addSubview(keywordTextField)
        topBoxView.addSubview(searchBtn)
        
        
        let botPageRect = CGRect(x: 0, y: 40, width: kScreenW, height: 30)
        botPageView = PageTitleView.init(frame: botPageRect, titles: ["默认", "价格", "销量", "浏览数"])
        botPageView?.delegate = self
        
        headerView.addSubview(topBoxView)
        headerView.addSubview(botPageView!)
        
        return headerView
    }
}

extension SearchVC {
    // MARK: -- 搜索响应事件
    func searchBtnAction() -> Void {
        
        if keywordTextField.text?.characters.count == 0 {
            showHint(in: view, hint: "请输入要搜索的内容")
            return
        }
        
        isLoad = false
        
        dataArr = []
        
        colView?.reloadData()
        
        currentPage = 1
        
        currentType = 4
        
        getSearchDate(type: currentType, fage: keywordTextField.text!, pages: currentPage)
    }
    // MARK: -- PageTitleViewDelegate
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int) {
        
        isLoad = false
        
        dataArr = []
        
        colView?.reloadData()
        
        currentPage = 1
        
        currentType = index
        
        getSearchDate(type: currentType, fage: "0", pages: currentPage)
    }
}

//?: 为什么延展里不能遵守layout协议
extension SearchVC:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
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
        
        let model = dataArr[indexPath.row]
        model.cGoodsImagePath = "hlm_test_pic.jpg"
        cell.shopCartModel = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = dataArr[indexPath.row]
        
        let vc = GoodsDetailViewController()
        vc.cGoodsNo = model.cGoodsNo
        vc.price = model.fNormalPrice
        vc.vipPrice = model.fVipPrice
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if  colView?.cellForItem(at: IndexPath(row: dataArr.count - 3, section: 0)) != nil && self.isLoad {
            //当滚动到精猜生活headerview的时候去请求 精彩生活的网络数据
            self.isLoad = false
            currentPage += 1
            getSearchDate(type: currentType, fage: "0", pages: currentPage)
        }
    }
    //滑动时不让点击botPageView
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        botPageView?.setLabelUserInterface(state: false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        botPageView?.setLabelUserInterface(state: true)
    }
    
}




















