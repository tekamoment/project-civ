//
//  ProjectUpdateTitleCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class ProjectUpdateTitleCell: UICollectionViewCell {
    static let titleFont = UIFont(name: "Tofino-Bold", size: 25)!
    static let authorFont = UIFont(name: "Tofino-Book", size: 14)!
    
    static let commonInset = UIEdgeInsets(top: 8, left: 15, bottom: 10, right: 15)
    
    static func cellSize(width: CGFloat, titleString: String, authorString: String) -> CGSize {
        let titleBounds = TextSize.size(titleString, font: ProjectUpdateTitleCell.titleFont, width: width, insets: commonInset)
        let authorBounds = TextSize.size(authorString, font: ProjectUpdateTitleCell.authorFont, width: width, insets: ProjectUpdateTitleCell.commonInset)
        return CGSize(width: width, height: titleBounds.height + authorBounds.height)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectUpdateTitleCell.titleFont
        label.textColor = UIColor(hex6: 0x387780)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = ProjectUpdateTitleCell.authorFont
        label.textColor = UIColor(hex6: 0x757780)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let authorLabelRect = TextSize.size(authorLabel.text!, font: ProjectUpdateTitleCell.authorFont, width: frame.width, insets: ProjectUpdateTitleCell.commonInset)
        authorLabel.frame = UIEdgeInsetsInsetRect(authorLabelRect, ProjectUpdateTitleCell.commonInset)
        authorLabel.frame.origin.y = frame.height - authorLabelRect.size.height
        
        let titleLabelRect = TextSize.size(titleLabel.text!, font: ProjectUpdateTitleCell.titleFont, width: frame.width, insets: ProjectUpdateTitleCell.commonInset)
        titleLabel.frame = UIEdgeInsetsInsetRect(titleLabelRect, ProjectUpdateTitleCell.commonInset)
        titleLabel.frame.origin.y = authorLabel.frame.origin.y - titleLabel.frame.height
    }
}
