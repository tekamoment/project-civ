//
//  ProjectCoverViewCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class ProjectCoverViewCell: UICollectionViewCell {
    static let commonInsets = UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15)
    static let nameFont = UIFont(name: "Tofino-Bold", size: 40)!
    static let locationFont = UIFont(name: "Tofino-Book", size: 20)!
    
    var delegate: ProjectCoverViewCellDelegate?
    
    static func cellSize(width: CGFloat, nameString: String, locationString: String) -> CGSize {
        let nameBounds = TextSize.size(nameString, font: ProjectCoverViewCell.nameFont, width: width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15))
        let locationBounds = TextSize.size(locationString, font: ProjectCoverViewCell.locationFont, width: width, insets: ProjectCoverViewCell.commonInsets)
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
        imageView.image = UIImage(named: "hellohello.jpg")
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectCoverViewCell.nameFont
//        label.textColor = UIColor(hex6: 0xE83151)
        label.textColor = UIColor.white
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectCoverViewCell.locationFont
        label.textColor = UIColor(hex6: 0xDBD4D3)
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont(name: "Tofino-Bold", size: 20)!
        button.titleLabel?.textColor = UIColor.blue
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Info", for: .normal)
        button.titleLabel?.font = UIFont(name: "Tofino-Bold", size: 20)!
        button.titleLabel?.textColor = UIColor.blue
        button.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        
        contentView.addSubview(closeButton)
        contentView.addSubview(infoButton)
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.frame
        
        let locationLabelRect = TextSize.size(locationLabel.text!, font: ProjectCoverViewCell.locationFont, width: frame.width, insets: ProjectCoverViewCell.commonInsets)

        locationLabel.frame = UIEdgeInsetsInsetRect(locationLabelRect, UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15))
        
        locationLabel.frame.origin.y = frame.height - locationLabelRect.size.height
        
        let nameLabelRect = TextSize.size(nameLabel.text!, font: ProjectCoverViewCell.nameFont, width: frame.width, insets: UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15))

        nameLabel.frame = UIEdgeInsetsInsetRect(nameLabelRect, UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15))
        
        nameLabel.frame.origin.y = locationLabel.frame.origin.y - nameLabel.frame.height
        
        closeButton.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        
        infoButton.frame = CGRect(x: frame.width - 60, y: 20, width: 40, height: 40)
    }
    
    func closeTapped() {
        delegate?.closeTapped()
    }
    
    func infoTapped() {
        delegate?.infoTapped()
    }
   
}

protocol ProjectCoverViewCellDelegate {
    func closeTapped()
    func infoTapped()
}
