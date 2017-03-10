//
//  ClassifyLeftTableCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit


class ClassifyLeftTableCell: UITableViewCell {

    var leftImageView:UIImageView = {() -> UIImageView in
        let imageview = UIImageView.init(image: nil, highlightedImage: UIImage.init(named: "mainColordot"))
        return imageview
    }()
    
    var rightLabel = {UILabel.init()}()
    

    func setRightLabelText(_ text:String) {
        rightLabel.text = text
        rightLabel.textAlignment = NSTextAlignment.center
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            rightLabel.textColor = UIColor.appMainColor()
        } else {
            rightLabel.textColor = UIColor.init(gray: 110)
        }
    }
    
    
    override func layoutSubviews() {
        
        leftImageView.frame  = CGRect(x: 0, y: -2, width: 3, height: self.bounds.size.height + 4)
        rightLabel.frame = CGRect(x: 3, y: 0, width: self.bounds.size.width - 3, height: self.bounds.size.height)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //定义点击cell时改变cell的颜色
        let cellBgView = UIView.init(frame: self.bounds)
        cellBgView.backgroundColor = UIColor.init(gray: 254)
        self.selectedBackgroundView = cellBgView
        
        
        self.contentView.addSubview(leftImageView)
        self.contentView.addSubview(rightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
