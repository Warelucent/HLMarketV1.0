//
//  UnpostOrderTableCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 12/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class UnpostOrderTableCell: UITableViewCell {

    lazy var subView:GoodsControlView = {[weak self] in
        let view = GoodsControlView.init(frame: CGRect.zero, type: .counts)
        return view
        }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(subView)
    }
    
    override func layoutSubviews() {
        subView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.size.height -= 1
            super.frame = newFrame
        }
    }


}
