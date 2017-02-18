//
//  ProjectNameLocationViewCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class ProjectNameLocationViewCell: UICollectionViewCell {
    static let commonInsets = UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)
    static let nameFont = UIFont(name: "Tofino-Bold", size: 25)!
    static let locationFont = UIFont(name: "Tofino-Book", size: 15)!
    
    static func cellSize(width: CGFloat, nameString: String, locationString: String) -> CGSize {
        let nameBounds = TextSize.size(nameString, font: ProjectNameLocationViewCell.nameFont, width: width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15))
        let locationBounds = TextSize.size(locationString, font: ProjectNameLocationViewCell.locationFont, width: width, insets: ProjectNameLocationViewCell.commonInsets)
        return CGSize(width: width, height: nameBounds.height + locationBounds.height)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectNameLocationViewCell.nameFont
        label.textColor = UIColor(hex6: 0x387780)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectNameLocationViewCell.locationFont
        label.textColor = UIColor(hex6: 0xDBD4D3)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let nameLabelRect = TextSize.size(nameLabel.text!, font: ProjectNameLocationViewCell.nameFont, width: frame.width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15))
        nameLabel.frame = UIEdgeInsetsInsetRect(nameLabelRect, UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15))
        
        let locationLabelRect = TextSize.size(locationLabel.text!, font: ProjectNameLocationViewCell.locationFont, width: frame.width, insets: ProjectNameLocationViewCell.commonInsets)
        locationLabel.frame = UIEdgeInsetsInsetRect(locationLabelRect, ProjectNameLocationViewCell.commonInsets)
        locationLabel.frame.origin.y = nameLabelRect.size.height
        
    }
}
