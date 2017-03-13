//
//  HLDIGOUSWIFT
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

//图片在上方的button
import UIKit

class HLTopBtn: UIButton {

    var margin : CGFloat = 5
    /**
     图片在上面的Button
     */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.HL_centerX = HL_width * 0.5
        imageView?.HL_centerY = HL_height * 0.5 * 0.7
        
        titleLabel?.sizeToFit()
        
        titleLabel?.HL_centerX = HL_width * 0.5
        titleLabel?.HL_y = (imageView?.frame)!.maxY + margin

    }
}
