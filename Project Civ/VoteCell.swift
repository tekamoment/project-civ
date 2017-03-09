//
//  VoteCell.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class VoteCell: UICollectionViewCell {
    static let font = UIFont(name: "Tofino-Bold", size: 25)!
    static let inset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    
    var delegate: VoteCellDelegate?
    
    let upvoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex6: 0x20bf55)
        button.titleLabel?.font = VoteCell.font
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(upvoteTapped), for: .touchUpInside)
        return button
    }()
    
    let downvoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex6: 0xE83151)
        button.titleLabel?.font = VoteCell.font
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(downvoteTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(upvoteButton)
        contentView.addSubview(downvoteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offset: CGFloat = 15.0
        let rectSize = UIEdgeInsetsInsetRect(bounds, VoteCell.inset)
        let (left, uncutRight) = rectSize.divided(atDistance: (bounds.width / CGFloat(2.0) - offset), from: .minXEdge)
        let right = UIEdgeInsetsInsetRect(uncutRight, UIEdgeInsets(top: 0, left: offset / CGFloat(2.0), bottom: 0, right: 0))
        
        print("Left: \(left)")
        print("Right: \(right)")
        
        upvoteButton.frame = left
        downvoteButton.frame = right
    }
    
    func upvoteTapped() {
        delegate?.upvoteTapped()
    }
    
    func downvoteTapped() {
        delegate?.downvoteTapped()
    }
}

protocol VoteCellDelegate {
    func upvoteTapped()
    func downvoteTapped()
}
