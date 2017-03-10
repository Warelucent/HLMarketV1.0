//
//  ProfileCollectionCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit


protocol ProfileCollectionCellDelegate {
    
    
    
}


private let kProfileCollectionCellID = "kProfileCollectionCellID"

class ProfileCollectionCell: UITableViewCell {

    var delegate:ProfileCollectionCellDelegate?
    
    let itemHeight = 80.0
    
    let itemCount  = 5
    let itemWidth  = kScreenW / 5
    
    lazy var subCollectionView:UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:self!.itemWidth, height:80)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView.init(frame: (self?.bounds)!, collectionViewLayout: layout)
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kProfileCollectionCellID)
        
        return collectionView
        }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(subCollectionView)
        
        subCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        subCollectionView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension ProfileCollectionCell:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProfileCollectionCellID, for: indexPath)
        
        
        let textArray = [("hlm_all_orders", "全部订单"), ("hlm_order_unpay", "待付款"), ("hlm_post_goods", "待发货"), ("hlm_receive_goods", "待收货"), ("hlm_order_completed", "已完成")]
        
        let cellSubView:CellSubView = CellSubView.init(frame: cell.bounds)
        cellSubView.cellSubViewModel = ProfileCollectionCellModel.init(dict: ["text":textArray[indexPath.row].1, "imageName":textArray[indexPath.row].0])
        cell.addSubview(cellSubView)
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[\(indexPath.section), \(indexPath.row)]")
    }
}


class CellSubView:UIView {
    
    lazy var imageView = {() -> UIImageView in
        let imageview = UIImageView.init()
        return imageview;
    }()
    
    lazy var titleLabel = {() -> UILabel in
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    var cellSubViewModel:ProfileCollectionCellModel? {
        didSet {
            titleLabel.text = cellSubViewModel?.text
            let theImage = UIImage.init(named: (cellSubViewModel?.imageName)!)
            imageView.image = theImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        let kMargin:CGFloat = 10
        imageView.frame = CGRect(x: kMargin, y: kMargin, width: self.bounds.size.width - 2 * kMargin, height: self.bounds.size.width - 2 * kMargin)
        titleLabel.frame = CGRect(x: 0, y: 0.6 * self.bounds.size.height, width: self.bounds.size.width, height: 0.4 * self.bounds.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ProfileCollectionCellModel: NSObject {
    
    var text:String = ""
    var imageName:String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}

