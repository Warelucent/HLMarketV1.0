//
//  ClassifyVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kClassRightCollectionViewID = "kClassRightCollectionViewID"
private let kClassRightCollectionViewCellMargin:CGFloat = 8


class ClassifyVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var typeDic: Dictionary<String,String>?
    
    fileprivate lazy var leftTableView: ClassifyLeftTableView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW * (1 - 0.75), height: kScreenH - kTabBarH)
        let leftTableView = ClassifyLeftTableView(frame: rect)
        leftTableView.titleBlock = { [weak self] data in
            let model = data as! LeftTableViewModel
            return model.cGroupTypeName
        }
        leftTableView.selectBlock = { [weak self] data in
            self!.selectLeftTableView(model: data as! LeftTableViewModel)
        }
        return leftTableView
    }()
    
    fileprivate lazy var rightCollectionView: UICollectionView =  { [weak self] in
        
        let rect = CGRect(x: kScreenW * (1 - 0.75), y: 0, width: kScreenW * 0.75, height: kScreenH - kTabBarH)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (kScreenW * 0.75 - 3 * kClassRightCollectionViewCellMargin)/2.0
        let size = CGSize(width:itemWidth, height:itemWidth*1.5)
        layout.itemSize = size
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let colView = UICollectionView(frame: rect, collectionViewLayout:layout)
        colView.delegate = self
        colView.dataSource = self
        colView.register(ShopCartStyleCell.self, forCellWithReuseIdentifier: kClassRightCollectionViewID)
        colView.backgroundColor = UIColor.white
        self?.view.addSubview(colView)
        return colView
    }()
    
    fileprivate var leftArr = Array<LeftTableViewModel>()
    
    fileprivate var rightArr = Array<RightCollectionViewModel>()
    
    fileprivate var currentLeftModel: LeftTableViewModel?
    
    fileprivate var currentPage = 1
    
    fileprivate var isLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(gray: 254)
        self.view.addSubview(leftTableView)
        getLeftArrData()
        
    }
    // MARK: -- 获取左侧栏数据
    func getLeftArrData() -> Void {
        
        if self.typeDic == nil {
            showHint(in: view, hint: "类型为空")
            return
        }
        
        let parameters = ["cParentNo":"\(self.typeDic!["typeNo"]!)"]
        
        AlamofireNetWork.required(urlString: "/Simple_online/Select_left_Group", method: .post, parameters: parameters, success: { (result) in
            
//            print(result)
            
            let json = JSON(result)
            
            if json["resultStatus"] == "1" {
                
                let data = json["dDate"].arrayObject
                
                self.leftArr = LeftTableViewModel.mj_objectArray(withKeyValuesArray: data) as! Array<LeftTableViewModel>
                
                self.leftTableView.reloadData(arr: self.leftArr)
                
            }else {
                self.showHint(in: self.view, hint: "类别为空")
            }
            
        }) { (error) in
            
        }
        
    }
    // MARK: -- 左边栏点击事件
    func selectLeftTableView(model: LeftTableViewModel) -> Void {
        
        self.isLoad = false
        
        rightArr = []
        
        rightCollectionView.reloadData()
        
        currentLeftModel = model
        
        currentPage = 1
        
        getRightArrData(cGroupTypeNo: currentLeftModel!.cGroupTypeNo, pages: currentPage)
        
    }
    // MARK: -- 获取右侧栏数据
    func getRightArrData(cGroupTypeNo: String, pages: Int) -> Void {
        
        let parameters = ["cGroupTypeNo":cGroupTypeNo,"Number_of_pages":"\(pages)"]
        
        AlamofireNetWork.required(urlString: "/Simple_online/Select_right_goods", method: .post, parameters: parameters, success: { (result) in
            
//            print(result)
            
            let json = JSON(result)
            
            if json["resultStatus"] == "1" {
                
                let data = json["dDate"].arrayObject
                
                let modelArr = RightCollectionViewModel.mj_objectArray(withKeyValuesArray: data) as! Array<RightCollectionViewModel>
                
                self.rightArr = self.rightArr + modelArr
                
                self.rightCollectionView.reloadData()
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

extension ClassifyVC {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rightArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShopCartStyleCell = collectionView.dequeueReusableCell(withReuseIdentifier: kClassRightCollectionViewID, for: indexPath) as! ShopCartStyleCell
        
        cell.backgroundColor = UIColor.white
        
        cell.layer.borderColor = UIColor.init(gray: 246).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        //cell.layer.shadowOpacity = 0.8
        //cell.layer.shadowColor = UIColor.black.cgColor
        //cell.layer.shadowOffset = CGSize(width:1, height:1)
        
        let model = rightArr[indexPath.row]
        model.cGoodsImage = "hlm_test_pic.jpg"
        cell.rightCollectionViewModel = model
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if  rightCollectionView.cellForItem(at: IndexPath(row: rightArr.count - 3, section: 0)) != nil && self.isLoad {

            //当滚动到精猜生活headerview的时候去请求 精彩生活的网络数据
            self.isLoad = false
            currentPage += 1
            getRightArrData(cGroupTypeNo: currentLeftModel!.cGroupTypeNo, pages: currentPage)
        }
        
    }
    
    //滑动时不让点击botPageView
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        leftTableView.setTableViewUserInterface(state: false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       leftTableView.setTableViewUserInterface(state: true)
    }
    
}


