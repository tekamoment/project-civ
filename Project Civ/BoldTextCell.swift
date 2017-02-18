//
//  BoldTextCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class BoldTextCell: UICollectionViewCell {
    static let font = UIFont(name: "Tofino-Bold", size: 18)!
    static let inset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 15)
    
    static func cellSize(width: CGFloat, string: String) -> CGSize {
        return TextSize.size(string, font: BoldTextCell.font, width: width, insets: BoldTextCell.inset).size
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.font = BoldTextCell.font
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
        label.frame = UIEdgeInsetsInsetRect(bounds, BoldTextCell.inset)
    }
}
