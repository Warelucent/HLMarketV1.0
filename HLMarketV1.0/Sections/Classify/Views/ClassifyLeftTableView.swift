//
//  ClassifyLeftTableView.swift
//  HLMarketV1.0
//
//  Created by 彭仁帅 on 2017/3/10.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit

private let kClassifyTableViewCell = "kClassifyTableViewCell"
private let kClassifyTableViewCellHeight = 44

typealias ClassifyLeftTableViewSelectBlock = (_ data: Any) -> ()
typealias ClassifyLeftTableViewTitleBlock = (_ data: Any) -> String

class ClassifyLeftTableView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var selectBlock: ClassifyLeftTableViewSelectBlock?
    var titleBlock: ClassifyLeftTableViewTitleBlock?
    
    fileprivate var tableView = UITableView()
    
    fileprivate var dataArr = [Any]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        //设定tableview的样式
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.register(ClassifyLeftTableCell.self, forCellReuseIdentifier: kClassifyTableViewCell)
    }
    
    func reloadData(arr: [Any]) -> Void {
        dataArr = arr
        tableView.reloadData()
        
        //点击第一个cell
        tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .none)
        tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
    }
    
    func setTableViewUserInterface(state: Bool) -> Void {
        tableView.allowsSelection = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ClassifyLeftTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kClassifyTableViewCell) as! ClassifyLeftTableCell
        
        let model = dataArr[indexPath.row]
        
        if self.titleBlock != nil {
            cell.setRightLabelText(self.titleBlock!(model))
        }
        
        cell.backgroundColor = UIColor.init(gray: 252)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(kClassifyTableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArr[indexPath.row]
        
        if self.selectBlock != nil {
            self.selectBlock!(model)
        }
    }
}

