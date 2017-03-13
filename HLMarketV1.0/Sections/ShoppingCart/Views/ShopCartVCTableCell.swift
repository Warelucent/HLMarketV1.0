//
//  ShopCartVCTableCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 11/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit



//MARK: --- 可以在每个cell的增减按钮上面添加一个删除和收藏按钮

class ShopCartVCTableCell: UITableViewCell {

    dynamic var isChecked:Bool = false
    
    var model:ShopCartGoodModel? {
        didSet{
            let goodsControlModel = GoodsControlModel.init(dict: ["avtarImage":model!.avtarImage, "title":model!.name, "price":model!.price, "count":model!.count])
            goodsControlView.model = goodsControlModel
            //isChecked = (model?.isSelected)!
        }
    }
    
    lazy var checkBoxBtn:UIButton = {[weak self] in
        let btn = UIButton.init(type: .system)
        btn.setImage(UIImage.init(named: "hlm_checkbox_nor")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(ShopCartVCTableCell.changeState), for: .touchUpInside)
        return btn
    }()
    
    lazy var goodsControlView  = { () -> GoodsControlView in
        let rect = CGRect.zero
        let view = GoodsControlView.init(frame: rect, type: .plusOrReduce)
//        let model = GoodsControlModel.init(dict: ["avtarImage":"hlm_test_pic.jpg", "title":"大白菜", "price":"3.8", "count":"2"])
//        view.model = model
        return view
    }()
    
    
    func changeState() {
        isChecked = !isChecked
        if isChecked {
            checkBoxBtn.setImage(UIImage.init(named: "hlm_checkbox_select")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            checkBoxBtn.setImage(UIImage.init(named: "hlm_checkbox_nor")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(checkBoxBtn)
        self.contentView.addSubview(goodsControlView)
        self.addObserver(self, forKeyPath: "isChecked", options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        checkBoxBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        goodsControlView.snp.makeConstraints { (make) in
            make.left.equalTo(checkBoxBtn.snp.right).offset(0)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview()
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.model?.isSelected = isChecked
        print("4444444444444444\(keyPath)")
    }
    
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            //newFrame.origin.x += 10/2
            //newFrame.size.width -= 10
            //newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
}
