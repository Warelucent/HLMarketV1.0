//
//  AddNewAdressInfoCell.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

class AddNewAdressInfoCell: UITableViewCell {

    lazy var titleLabel = { () -> UILabel in
        let label = UILabel.init()
        label.textColor = UIColor.init(gray: 118)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
   lazy var inputTextField = { () -> UITextField in
        let textfield = UITextField.init()
        textfield.font = UIFont.systemFont(ofSize: 16)
    
        return textfield
    }()
    
    var titleLabelText:String? {
        didSet{
            titleLabel.text = titleLabelText
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(inputTextField)
        inputTextField.delegate = self
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(80)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(-5)
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(titleLabel.snp.right).offset(5)
        }
    }
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            //newFrame.origin.x += 10/2
            //newFrame.size.width -= 10
            //newFrame.origin.y += 10
            newFrame.size.height -= 1
            super.frame = newFrame
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AddNewAdressInfoCell:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputTextField.resignFirstResponder()
    }
}
