//
//  ANASetDefaultCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class ANASetDefaultCell: UITableViewCell {

    lazy var boxView = {UIView.init()}()
    
    lazy var checkBtn = {() -> UIButton in
        let btn = UIButton.init(type: UIButtonType.system)
        let theImage = UIImage.init(named: "hlm_disSelected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        btn.setImage(theImage, for: UIControlState.normal)
        return btn
    }()
    
    var isChecked:Bool = false
    
    func  changeState() {
        if isChecked {
            checkBtn.setImage(UIImage.init(named: "hlm_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            titleLabel.textColor = UIColor.appMainColor()
        } else {
            checkBtn.setImage(UIImage.init(named: "hlm_disSelected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for:.normal)
            titleLabel.textColor = UIColor.init(gray: 110)
        }
        isChecked = !isChecked
    }
    lazy var titleLabel = { () -> UILabel in
        let label = UILabel.init()
        label.text = "设为默认收货地址"
        label.textColor = UIColor.init(gray: 110)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(boxView)
        boxView.addSubview(checkBtn)
        boxView.addSubview(titleLabel)
        checkBtn.addTarget(self, action: #selector(ANASetDefaultCell.changeState), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        boxView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 1, 0))
        }
        checkBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(16)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.618)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.right.equalToSuperview().offset(-5)
            make.left.equalTo(checkBtn.snp.right).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
