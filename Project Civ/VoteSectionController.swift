//
//  VoteSectionController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import IGListKit

class VoteSectionController: IGListSectionController {
    var project: Project!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 15)
    }
}

extension VoteSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext, let _ = project else { return .zero }
        let width = context.containerSize.width
        return CGSize(width: width, height: 125)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: VoteCell.self, for: self, at: index) as! VoteCell
        cell.upvoteButton.titleLabel?.text = "+" + String(describing: project.upvotes)
        cell.downvoteButton.titleLabel?.text = "-" + String(describing: project.downvotes)
        return cell
    }
    
    func didUpdate(to object: Any) {
        project = object as? Project
    }
    
    func didSelectItem(at index: Int) {
        // fill this in
    }
}
