//
//  DateCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    static let font = UIFont(name: "Tofino-Book", size: 14)!
    
    let label : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = DateCell.font
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        label.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, padding.left, 0, padding.right))
    }
}
