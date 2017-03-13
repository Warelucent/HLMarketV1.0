//
//  ProfileInfoLabelCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit
import Foundation

private let kProfileLabelCellMargin:CGFloat = 5

struct InitBtnTag {
    static var value = 23
}

typealias BtnClickClosure = (_ tag:Int?)->Void

class ProfileInfoLabelCell: UITableViewCell {

    /*
    lazy var boxBtn = {() -> UIButton in
        let boxbtn = UIButton.init(type: UIButtonType.system)
        return boxbtn
    }()
    
    lazy var topLabel = {() -> UILabel in
        let label = UILabel.init()
        return label
    }()
    
    lazy var botLabel = {() -> UILabel in
        let label = UILabel.init()
        return label
    }()
    
    lazy var sepLineLabel = {() -> UILabel in
        let label = UILabel.init()
        return label
    }()
    */
    
    var btnClickClosure:BtnClickClosure?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var boxBtnsArray:[UIButton]? = []
    
    func setupUI() {
        var i = 0
        while i < boxCount {
            self.boxBtnsArray?.append(self.createOneBoxBtn((textArray?[i])!))
            i += 1
        }
    }
    
    func layoutUI() {
        
        let totalBtnWidth = CGFloat(kScreenW) - CGFloat(boxCount) + 1 - CGFloat(boxCount) * 2 * kProfileLabelCellMargin
        let btnWidth = totalBtnWidth / CGFloat(boxCount)
        for btn:UIButton in boxBtnsArray! {
            let index = boxBtnsArray?.index(of: btn)
            var i = 0
            if (index != nil) {
                i = index!
            }
            let kMarginLeft = kProfileLabelCellMargin +  CGFloat(i) * (btnWidth + 1 + 2 * kProfileLabelCellMargin)
            btn.frame = CGRect(x: kMarginLeft, y: kProfileLabelCellMargin, width:btnWidth, height: self.bounds.size.height)
            btn.tag = InitBtnTag.value + 100
            InitBtnTag.value += 1
            self.contentView.addSubview(btn)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        }
        var labelIndex = 0
        repeat {
            let labelBounds = CGRect(x: CGFloat(labelIndex + 1) * (btnWidth + 2 * kProfileLabelCellMargin), y: kProfileLabelCellMargin, width: 0.5, height: self.bounds.size.height - 2 * kProfileLabelCellMargin)
            let sepLineLabel = UILabel.init(frame:labelBounds)
            sepLineLabel.backgroundColor = UIColor.init(gray: 210)
            
            self.contentView.addSubview(sepLineLabel)
            labelIndex += 1
        } while labelIndex < boxCount - 1
    }
    
    
    
    func btnClick(sender:UIButton?) {
        if (btnClickClosure != nil) {
            btnClickClosure!(sender?.tag)
        }
    }
    //-------------  建议数值不要超过4
    var boxCount:Int {
        get {
            if textArray != nil {
                return (textArray?.count)!
            } else {
                return 0
            }
        }
    }
    
    var textArray:[(values:String, title: String)]? {
        didSet {
            setupUI()
            layoutUI()
            }
        }
    
    func createOneBoxBtn(_ tupleTitle:(values:String, title:String)) -> UIButton {
        let boxBtn = UIButton.init(type: UIButtonType.system)
        
        let topLabel = UILabel.init()
        let botLabel = UILabel.init()
        
        boxBtn.addSubview(topLabel)
        boxBtn.addSubview(botLabel)
        
        topLabel.textAlignment = NSTextAlignment.center
        botLabel.textAlignment = NSTextAlignment.center
        
        topLabel.font = UIFont.systemFont(ofSize: 16)
        botLabel.font = UIFont.systemFont(ofSize: 12)
        
        topLabel.textColor = UIColor.appMainColor()
        
        topLabel.text = tupleTitle.values
        botLabel.text = tupleTitle.title
        
        topLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.left.top.width.equalToSuperview()
        }
        botLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.left.bottom.width.equalToSuperview()
        }
        
        return boxBtn
    }
    
    
}
