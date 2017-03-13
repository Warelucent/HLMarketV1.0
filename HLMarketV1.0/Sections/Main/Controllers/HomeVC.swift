//
//  HomeVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import SwiftyJSON

let CViewCellMargin: CGFloat = 8//collectionView的cell之间的间隔
let CViewCellWid: CGFloat = (kScreenW - 5 * 8)/4//collectionView的cell宽度
let CViewCellHei: CGFloat = 60//collectionView的cell宽度
let CViewCellWid1: CGFloat = (kScreenW - 3 * 8)/2//collectionView的cell宽度
func CViewCeil(_ count: Int, _ divisor: Int) -> CGFloat{return CGFloat(ceil(Float(count)/Float(divisor)))}//数组count除以2在向上取整
let ClassifyTypeColViewID = "ClassifyTypeColViewID"
let ClassifyTypeColViewCellID = "ClassifyTypeColViewCellID"
let VADColViewID = "VADColViewID"
let VADColViewCellID = "VADColViewCellID"

class HomeVC: BaseViewController,XRCarouselViewDelegate {
    
    //tableView
    fileprivate lazy var tableView: UITableView? = {
        let tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-kStatusBarH-kNavigationBarH-kTabBarH), style: UITableViewStyle.grouped)
        ///注册cellID
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.ID)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: ClassifyTypeColViewID)
        tableView.register(UINib (nibName: "HLTableSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: self.SectionHeaderViewID)
        
        //隐藏滑块
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    //轮播图
    fileprivate lazy var carouselView:XRCarouselView = XRCarouselView()
    //轮播图 图片网址数组/图片名字数组
    fileprivate lazy var imageUrls = [String]()
    fileprivate lazy var imageNames = [String]()
    ///可拉伸tableViewHeaderView
    fileprivate var stretchHeaderView :HLStretchableTableHeaderView?
    ///背景图片
    fileprivate var backgroundView :UIView?
    //偏移量
    fileprivate var scrolloffset : CGFloat = 0
    fileprivate let scrollh :CGFloat = kScreenH/4
    
    //cellID
    fileprivate let ID = "cell"
    fileprivate let SectionHeaderViewID = "sectionheaderview"
    
    fileprivate var time : Int = 1
    
    fileprivate var sections : Int = 0
    
    fileprivate var dataArr1 = [HADModel]()
    fileprivate var dataArr2 = [ClassifyTypeModel]()
    fileprivate var dataArr3 = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHomeData()
        
        self.setup()
    }
    
}

// MARK: - 初始化
extension HomeVC{
    
    /// 初始化
    func setup()  {
        //禁止自动调整(顶部不保留每个section的header)
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(tableView!)
        //添加下拉刷新控件
        let refreshHeader = MJRefreshGifHeader { [weak self] in
            self?.getHomeData()
        }

        refreshHeader?.setImages([UIImage.init(named: "icon_hud_1_107x66_")!,
                                  UIImage.init(named: "icon_hud_2_107x66_")!,
                                  UIImage.init(named: "icon_hud_3_107x66_")!,
                                  UIImage.init(named: "icon_hud_4_107x66_")!,
                                  UIImage.init(named: "icon_hud_5_107x66_")!,
                                  UIImage.init(named: "icon_hud_6_107x66_")!,
                                  UIImage.init(named: "icon_hud_7_107x66_")!,
                                  UIImage.init(named: "icon_hud_8_107x66_")!],
                                 duration: 1,
                                 for: MJRefreshStateRefreshing)
        
        tableView?.header = refreshHeader
        //添加轮播图
        self.addCarouselView()
    }
    
}


// MARK: - 加载网络数据
extension HomeVC{
    
    func getHomeData(){
        
        AlamofireNetWork.required(urlString: "/Simple_online/advertisement", method: .post, parameters: nil, success: { (result) in
            
            if self.tableView != nil {
                self.tableView?.header.endRefreshing()
            }
            
            let json = JSON(result)
            
            var resultDict = JSON.null
            
            if json["resultStatus"] == "1" {
                
                self.setJsonData(json: json)
                
                //数据返回成功 保存plist到沙盒中
                self.savePlist(data: result as AnyObject,filename: "HomeData.plist")
                
            }else {
                ///数据返回失败 从沙盒中获取
                resultDict = JSON(self.getPlist(filename: "HomeData.plist"))
                
                if resultDict == JSON.null {
                    return
                }
                
                self.setJsonData(json: resultDict)

            }
            
        }) { (error) in
            
            if self.tableView != nil {
                self.tableView?.header.endRefreshing()
            }
            
            var resultDict = JSON.null
            
            ///数据返回失败 从沙盒中获取
            resultDict = JSON(self.getPlist(filename: "HomeData.plist"))
            
            if resultDict == JSON.null {
                return
            }

            self.setJsonData(json: resultDict)
        }

    }
    
    func setJsonData(json: JSON) -> Void {
        
        self.imageUrls = []
        
        self.imageNames = []
        
        let arr1 = json["array1"].arrayObject
        
        let arr2 = json["array2"].arrayObject
        
        let arr3 = json["array3"].array
        
        self.dataArr1 = HADModel.mj_objectArray(withKeyValuesArray: arr1).copy() as! [HADModel]
        
        for model in self.dataArr1 {
            self.imageUrls.append(DefaultURL+"/Simple_online/"+model.adImagePath)
            self.imageNames.append(model.adcGoodsName)
        }
        
        self.dataArr2 = ClassifyTypeModel.mj_objectArray(withKeyValuesArray: arr2).copy() as! [ClassifyTypeModel]
        
        var newArr3 = [[String:Any]]()
        
        for i in 0..<arr3!.count {
            
            let dic = arr3![i]
            
            let modelArr = VADModel.mj_objectArray(withKeyValuesArray: dic["t_Goods"].arrayObject)
            
            newArr3.append(["title":dic["title"].description,"data":modelArr ?? [VADModel]()])
        }
        
        self.dataArr3 = newArr3
        
        self.tableView?.reloadData()
        carouselView.reload(withImageArray: self.imageUrls, describe: self.imageNames)
    }
    
    // MARK: -- XRCarouselViewDelegate
    @objc(carouselView:clickImageAtIndex:) func carouselView(_ carouselView: XRCarouselView!, clickImageAt index: Int) {
        
    }
    
}


// MARK: - 保存
extension HomeVC{
    func savePlist(data:AnyObject,filename:String) {
        //保存到plist文件中
        DispatchQueue.global().async {
            _ = data.write(toFile: SavePlistfilename(filename: filename), atomically: true)
        }
    }
    //获取plist文件
    func getPlist(filename:String) -> AnyObject {
        let plist = NSDictionary(contentsOfFile:SavePlistfilename(filename: filename))
        
        if plist != nil {
            return plist!
        }
        
        return "没数据" as AnyObject
    }
}


// MARK: - 代理
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    ///设置每组行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    ///设置组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1+dataArr3.count
    }
    
    ///设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = nil
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: ClassifyTypeColViewID)
            (cell as? HomeTableViewCell)?.collectionView.tag = 100
            (cell as? HomeTableViewCell)?.collectionView.delegate = self
            (cell as? HomeTableViewCell)?.collectionView.dataSource = self
            (cell as? HomeTableViewCell)?.collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: CViewCeil(dataArr2.count,4) * CViewCellHei + CViewCellMargin*(CViewCeil(dataArr2.count,4) + 1))
            cell?.contentView.addSubview((cell as? HomeTableViewCell)!.collectionView)
            (cell as? HomeTableViewCell)?.collectionView.reloadData()
            return cell!
        default:
            //防止复用cell
            cell = tableView.dequeueReusableCell(withIdentifier: VADColViewID+"\(indexPath.section)")
            if cell == nil {
                cell = HomeTableViewCell(style: .default, reuseIdentifier: VADColViewID+"\(indexPath.section)")
            }
            
            (cell as? HomeTableViewCell)?.collectionView1.tag = indexPath.section + 100
            (cell as? HomeTableViewCell)?.collectionView1.delegate = self
            (cell as? HomeTableViewCell)?.collectionView1.dataSource = self
            
            let arr = dataArr3[indexPath.section-1]["data"] as! [VADModel]
            
            (cell as? HomeTableViewCell)?.collectionView1.frame = CGRect(x: 0, y: 0, width: kScreenW, height: CViewCeil(arr.count,2) * (1.5 * CViewCellWid1) + CViewCellMargin*(CViewCeil(arr.count,2) + 1))
            cell?.contentView.addSubview((cell as? HomeTableViewCell)!.collectionView1)
            (cell as? HomeTableViewCell)?.collectionView.reloadData()
            return cell!
        }
    }
    
    
    
    ///组标题名
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : HLTableSectionHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderViewID) as? HLTableSectionHeaderView
        var text = ""
        
        if section > 0 {
            text = dataArr3[section-1]["title"] as! String
        }
        
        headerView?.titleLabel.text = text
        
        return headerView
        
    }
    
    ///设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return CViewCeil(dataArr2.count,4) * CViewCellHei + CViewCellMargin*(CViewCeil(dataArr2.count,4) + 1)
        default:
            let arr = dataArr3[indexPath.section-1]["data"] as! [VADModel]
            return CViewCeil(arr.count,2) * (1.5 * CViewCellWid1) + CViewCellMargin*(CViewCeil(arr.count,2) + 1)
        }
        
    }
    
    ///组尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    ///组头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return  40
        }
        
        
    }
    
    
    ///滚动监听
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.scrolloffset = scrollView.contentOffset.y
        
        
        //        ///替换 tableViewHeaderView 滚动图片
        //        if (offset < -scrollh * 0.25)&&isReLoad {
        //            // 下拉偏移量大于 scrollh * 0.25
        //            isReLoad = false
        //
        //            let  cookItem  =  topScrollView?.showImageView?.cookItem
        //            let  time      =  cookItem?.time
        //            let  times     = cookItem?.list.count
        //            //如果将要替换的图片是最后一张图片则数组标记time置0
        //            cookItem?.time = time! < times! - 1 ? (time! + 1) : 0
        //
        //
        //            //替换时的动画 先把图片透明度设为0.01然后替换模型 再将透明度复原
        //            UIView.animateWithDuration(0.2, animations: {
        //                self.topScrollView?.showImageView?.imageView.alpha = 0.01
        //                }, completion: { (true) in
        //                    self.topScrollView?.showImageView?.cookItem = cookItem
        //                    UIView.animateWithDuration(0.2, animations: {
        //                        self.topScrollView?.showImageView?.imageView.alpha = 1
        //                    })
        //            })
        //        }
        
        
        //根据拖动偏移量设置 topScrollView  的高度
        stretchHeaderView?.scrollViewDidScroll(scrollView: scrollView)
        
        //设置导航栏是否隐藏
        //        navigationController?.setNavigationBarHidden(offset < (scrollh - 64.0), animated: false)
        
        
        
        //        if  tableView.cellForRowAtIndexPath(NSIndexPath (forRow: self.lifeViewItems.count - 2 , inSection: 4)) != nil && self.isLoadLife  {
        //            //当滚动到精猜生活headerview的时候去请求 精彩生活的网络数据
        //            self.isLoadLife = false
        //            self.loadLifeMoreData()
        //        }
        
        
        //        if (scrollView == self.tableView)
        //        {
        //            let sectionHeaderHeight:CGFloat = scrollh+150+40+15; //sectionHeaderHeight
        //            if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        //                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        //            } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        //                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        //            }
        //        }
        //
        
    }
}

// MARK: - 添加水平广告轮播图
extension HomeVC{
    
    func addCarouselView() {
        carouselView = XRCarouselView(imageArray: imageUrls as [AnyObject], describe: imageNames as [AnyObject], andScale: CGSize(width: kScreenW, height: scrollh))
        carouselView.time = 4.0
        carouselView.delegate = self
        carouselView.setPageColor(UIColor.gray.withAlphaComponent(0.3), andCurrentPageColor: UIColor.appMainColor())
        carouselView.setDescribeTextColor(UIColor.appMainColor(), font: nil, bgColor: UIColor.clear)
        carouselView.pagePosition = PositionBottomRight
        carouselView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: scrollh)
        tableView?.tableHeaderView = carouselView
        
        //        backgroundView = UIView (frame: carouselView.frame)
        //        backgroundView!.backgroundColor = UIColor.clear
        //        //设置TableheaderView透明度为0 topScrollView获取焦点
        //        backgroundView!.alpha = 0
        //        //可拉伸的HeaderView
        //        stretchHeaderView = HLStretchableTableHeaderView()
        //        stretchHeaderView?.stretchHeaderForTableView(tableView: tableView, view: carouselView,viewFrame: CGRect(x: 0, y: 0, width: ScreenWidth, height: scrollh), subView: backgroundView!)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        tableView.contentInset = UIEdgeInsets (top: 0.0, left: 0.0, bottom: 40.0, right: 0.0)
        ///设置可拖拽tableViewHeaderView 的尺寸
        //        stretchHeaderView!.resizeView()
    }
    
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
        section: Int) -> Int {
        
        switch collectionView.tag {
        case 100:
            return dataArr2.count
        default:
            let dataIndex = collectionView.tag - 100 - 1
            let arr = dataArr3[dataIndex]["data"] as! [VADModel]
            return arr.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 100:
            let cell:HomeClassifyTypeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifyTypeColViewCellID, for: indexPath) as! HomeClassifyTypeCollectionViewCell
            
            cell.backgroundColor = UIColor.white
            
//            cell.layer.borderColor = UIColor.init(gray: 246).cgColor
//            cell.layer.borderWidth = 1
//            cell.layer.cornerRadius = 6
//            cell.layer.masksToBounds = true
            
            let model = dataArr2[indexPath.row]
            model.cIMG = "hlm_test_pic.jpg"
            cell.classifyTypeModel = model
            return cell
        default:
            let cell:ShopCartStyleCell = collectionView.dequeueReusableCell(withReuseIdentifier: VADColViewCellID, for: indexPath) as! ShopCartStyleCell
            
            cell.backgroundColor = UIColor.white
            
            cell.layer.borderColor = UIColor.init(gray: 246).cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 6
            cell.layer.masksToBounds = true
            //cell.layer.shadowOpacity = 0.8
            //cell.layer.shadowColor = UIColor.black.cgColor
            //cell.layer.shadowOffset = CGSize(width:1, height:1)
            
            let dataIndex = collectionView.tag - 100 - 1
            
            let arr = dataArr3[dataIndex]["data"] as! [VADModel]
            let model = arr[indexPath.row]
            
            model.cGoodsImagePath = "hlm_test_pic.jpg"
            cell.vADModel = model
            return cell
        }
        
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 100:
            let model = dataArr2[indexPath.row]
            let vc = ClassifyVC()
            vc.navigationItem.title = String.init(model.cGroupTypeName)
            vc.typeModel = model
            navigationController?.pushViewController(vc, animated: true)
        default:
            let dataIndex = collectionView.tag - 100 - 1
            let arr = dataArr3[dataIndex]["data"] as! [VADModel]
            let model = arr[indexPath.row]
            
            let vc = GoodsDetailViewController()
            vc.cGoodsNo = model.cGoodsNo
            vc.price = model.fNormalPrice
            vc.vipPrice = model.Recommend_price
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}


// MARK: - 生命周期
extension HomeVC{
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carouselView.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        carouselView.stopTimer()
    }
    
    //    override func preferredStatusBarStyle() -> UIStatusBarStyle {
    //        return UIStatusBarStyle.lightContent
    //    }
    
}




