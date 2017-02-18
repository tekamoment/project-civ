//
//  UITabBarController+TitleView.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    func setCustomTitleView(title: String) {
        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Tofino-Bold", size: 17)!,
            NSForegroundColorAttributeName:UIColor.black,
            NSKernAttributeName:CGFloat(2.0)
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes as? [String : AnyObject])
        
        setCustomTitleViewWithAttributedString(attributedTitle)

    }
    
    func setCustomTitleViewWithAttributedString(_ attrString: NSAttributedString) {
        let titleLabel = UILabel()
        
        titleLabel.attributedText = attrString
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
    
    
}
