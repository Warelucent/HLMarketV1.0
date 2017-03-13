//
//  SearchVC1.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/11.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kSearchCellCollectionViewCellID = "kSearchCellCollectionViewCellID"


class SearchVC1: BaseViewController {
    
    var searchStr = ""
    
    fileprivate lazy var collectionView: UICollectionView =  { [weak self] in
        
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kTabBarH)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (kScreenW - 3 * 8)/2.0
        let size = CGSize(width:itemWidth, height:itemWidth*1.5)
        layout.itemSize = size
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let colView = UICollectionView(frame: rect, collectionViewLayout:layout)
        colView.delegate = self
        colView.dataSource = self
        colView.register(ShopCartStyleCell.self, forCellWithReuseIdentifier: kSearchCellCollectionViewCellID)
        colView.backgroundColor = UIColor.white
        return colView
        }()
    
    fileprivate var dataArr = Array<ShopCartStyleModel>()
    
    fileprivate var currentPage = 1
    
    fileprivate var isLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 254)
        
        self.view.addSubview(collectionView)
        
        getSearchDate(fage: searchStr, pages: currentPage)
        
    }
    
    // MARK: -- 获取数据
    func getSearchDate(fage: String, pages: Int) -> Void {
        
        let parameters = ["Sort_type":"4","fage":fage,"Number_of_pages":"\(pages)"]
        
        AlamofireNetWork.required(urlString: "/Simple_online/Select_Search_Goods", method: .post, parameters: parameters, success: { (result) in
            
            print(result)
            
            let json = JSON(result)
            
            if json["resultStatus"] == "1" {
                
                let data = json["dDate"].arrayObject
                
                let modelArr = ShopCartStyleModel.mj_objectArray(withKeyValuesArray: data).copy() as! Array<ShopCartStyleModel>
                
                self.dataArr = self.dataArr + modelArr
                
                self.collectionView.reloadData()
                
                self.isLoad = true
                
            }else {
                
                if self.currentPage == 1 {
                    self.showHint(in: self.view, hint: "未搜索到相关信息")
                }else{
                    self.isLoad = false
                    self.currentPage -= 1
                }

            }
            
        }) { (error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension SearchVC1:UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        if  collectionView.cellForItem(at: IndexPath(row: dataArr.count - 3, section: 0)) != nil && self.isLoad {
            self.isLoad = false
            currentPage += 1
            getSearchDate(fage: "0", pages: currentPage)
        }
    }
    
}



