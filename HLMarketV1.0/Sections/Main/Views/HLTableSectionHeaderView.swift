//
//  HLDIGOUSWIFT
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

/// 可拉伸tableViewHeaderView


/// 自定义组头view
import UIKit

class HLTableSectionHeaderView: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        let imageView = UIImageView(image: UIImage(color: UIColor.white))
        imageView.frame = self.frame
        backgroundView = imageView
    }

}
