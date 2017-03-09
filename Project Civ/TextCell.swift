//
//  TextCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell {
    static let font = UIFont(name: "Tofino-Book", size: 14)!
    static let inset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 15)
    
    static func cellSize(width: CGFloat, string: String) -> CGSize {
        return TextSize.size(string, font: TextCell.font, width: width, insets: TextCell.inset).size
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.font = TextCell.font
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
        label.frame = UIEdgeInsetsInsetRect(bounds, TextCell.inset)
        print("layoutSubviews \(label.frame)")
    }
}
