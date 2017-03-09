//
//  ProjectNameLocationViewCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import QuartzCore

class ProjectNameLocationViewCell: UICollectionViewCell {
    static let commonInsets = UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15)
    static let nameFont = UIFont(name: "Tofino-Bold", size: 25)!
    static let locationFont = UIFont(name: "Tofino-Book", size: 12)!
    
    static func cellSize(width: CGFloat, nameString: String, locationString: String) -> CGSize {
        let nameBounds = TextSize.size(nameString, font: ProjectNameLocationViewCell.nameFont, width: width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15))
        let locationBounds = TextSize.size(locationString, font: ProjectNameLocationViewCell.locationFont, width: width, insets: ProjectNameLocationViewCell.commonInsets)
        return CGSize(width: width, height: nameBounds.height + locationBounds.height)
    }
    
    lazy var gradientLayer: CAGradientLayer! = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        
        
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.6, 1.0]
        return layer
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectNameLocationViewCell.nameFont
//        label.textColor = UIColor(hex6: 0x387780)
//        label.textColor = UIColor(hex6: 0xE83151)
        label.textColor = UIColor.white
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectNameLocationViewCell.locationFont
        label.textColor = UIColor(hex6: 0xDBD4D3)
//        label.textColor = UIColor(hex6: 0xE83151)
//        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        
        let locationLabelRect = TextSize.size(locationLabel.text!, font: ProjectNameLocationViewCell.locationFont, width: frame.width, insets: ProjectNameLocationViewCell.commonInsets)
        locationLabel.frame = UIEdgeInsetsInsetRect(locationLabelRect, ProjectNameLocationViewCell.commonInsets)
        locationLabel.frame.origin.y = frame.height - locationLabelRect.size.height
        
        let nameLabelRect = TextSize.size(nameLabel.text!, font: ProjectNameLocationViewCell.nameFont, width: frame.width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15))
        nameLabel.frame = UIEdgeInsetsInsetRect(nameLabelRect, UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15))
        nameLabel.frame.origin.y = locationLabel.frame.origin.y - nameLabel.frame.height
    }
}
