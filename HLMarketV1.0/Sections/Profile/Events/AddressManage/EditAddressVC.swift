//
//  AddNewAdressVC.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 09/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit


private let kAddNewAdressVCInfoCellID = "kAddNewAdressVCInfoCellID"
private let kAddNewAdressVCSetCellID = "kAddNewAdressVCSetCellID"
private let kAddNewAdressVDefaultCellID = "kAddNewAdressVDefaultCellID"




class EditAddressVC: UITableViewController {

    
    var areaString:String?
    var model:AddressUserModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "编辑收货地址"
        
        tableView.backgroundColor = UIColor.init(gray: 252)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        //注册三种不同cell id
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kAddNewAdressVDefaultCellID)
        tableView.register(AddNewAdressInfoCell.self, forCellReuseIdentifier: kAddNewAdressVCInfoCellID)
        tableView.register(ANASetDefaultCell.self, forCellReuseIdentifier: kAddNewAdressVCSetCellID)
        
    }

    func backAction() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 {
            let cell:AddNewAdressInfoCell = tableView.dequeueReusableCell(withIdentifier: kAddNewAdressVCInfoCellID, for: indexPath) as! AddNewAdressInfoCell
            let textArray = ["收货人", "手机号码", nil, "详细地址"]
            let textInputArray = [model?.UserName, model?.Tel, nil, model?.Detailaddress]
            
            cell.titleLabelText = textArray[indexPath.row]
            cell.inputTextField.text = textInputArray[indexPath.row]
            
            return cell
        } else if indexPath.row == 2 {
            let cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "areaCell")
            cell.textLabel?.text = "所在地区"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = UIColor.init(gray: 118)
            
            if areaString == nil {
                cell.detailTextLabel?.text = model?.UserMainAdressInfo
            } else {
                cell.detailTextLabel?.text = areaString
            }
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            return cell
        } else {
            let cell:ANASetDefaultCell = tableView.dequeueReusableCell(withIdentifier: kAddNewAdressVCSetCellID, for: indexPath) as! ANASetDefaultCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let boxView = UIView.init()
        boxView.backgroundColor = UIColor.white
        
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.frame = CGRect(x: kScreenW / 5, y: 7, width: kScreenW / 5 * 3, height: 40)
        boxView.addSubview(btn)
        
        btn.layer.borderColor = UIColor.init(r: 12, g: 205, b: 194).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.appMainColor().cgColor
        
        return boxView
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 4 {
            let cell:ANASetDefaultCell = tableView.cellForRow(at: indexPath) as! ANASetDefaultCell
            cell.changeState()
        }
        
        
        if indexPath.row == 2 {
                
                var contentArray = [LmyPickerObject]()
                let plistPath:String = Bundle.main.path(forAuxiliaryExecutable: "area.plist") ?? ""
                let plistArray = NSArray(contentsOfFile: plistPath)
                let proviceArray = NSArray(array: plistArray!)
                for i in 0..<proviceArray.count {
                    var subs0 = [LmyPickerObject]()
                    
                    let cityzzz:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                    let cityArray:NSArray = cityzzz.value(forKey: "cities") as! NSArray
                    for j in 0..<cityArray.count {
                        var subs1 = [LmyPickerObject]()
                        
                        let areazzz:NSDictionary = cityArray.object(at: j) as! NSDictionary
                        let areaArray:NSArray = areazzz.value(forKey: "areas") as! NSArray
                        for m in 0..<areaArray.count {
                            let object = LmyPickerObject()
                            object.title = areaArray.object(at: m) as? String
                            subs1.append(object)
                        }
                        let citymmm:NSDictionary = cityArray.object(at: j) as! NSDictionary
                        let cityStr:String = citymmm.value(forKey: "city") as! String
                        let object = LmyPickerObject()
                        object.title = cityStr
                        subs0.append(object)
                        object.subArray = subs1
                    }
                    let provicemmm:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                    let proviceStr:String? = provicemmm.value(forKey: "state") as! String?
                    let object = LmyPickerObject()
                    object.title = proviceStr
                    object.subArray = subs0
                    contentArray.append(object)
                }
                
                let picker = LmyPicker(delegate: self , style: .nomal)
                picker.contentArray = contentArray
                picker.show()
            }
        }
}
    

extension EditAddressVC:PickerDelegate {
    
    func chooseDate(picker: LmyPicker, date: Date) {
        areaString = date.string_from(formatter: "yyyy-MM-dd")
        tableView.reloadData()
    }
    
    func chooseElements(picker: LmyPicker, content: [Int : Int]) {
        var str:String = ""
        if let array = picker.contentArray {
            var tempArray = array
            for i in 0..<content.keys.count {
                let value:Int! = content[i]
                if value < tempArray.count {
                    let obj:LmyPickerObject = tempArray[value]
                    let title = obj.title ?? ""
                    if str.characters.count>0 {
                        str = str.appending("-\(title)")
                    }else {
                        str = title;
                    }
                    if let arr = obj.subArray {
                        tempArray = arr
                    }
                }
            }
            areaString = str
            tableView.reloadData()
        }
    }
}


















