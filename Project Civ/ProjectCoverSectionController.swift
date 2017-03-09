//
//  ProjectCoverSectionController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import IGListKit
import FirebaseStorage
import FirebaseStorageUI

class ProjectCoverSectionController: IGListSectionController, ProjectCoverViewCellDelegate {
    var project: Project!
    var delegate: ProjectCoverSectionControllerDelegate?
}

extension ProjectCoverSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 2
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext, let _ = project else { return .zero }
        
        let width = context.containerSize.width
        
        if index == 0 {
            return CGSize(width: context.containerSize.width, height: context.containerSize.height)
        } else {
            return CGSize(width: width, height: 70)
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
        let cell = collectionContext!.dequeueReusableCell(of: ProjectCoverViewCell.self, for: self, at: index) as! ProjectCoverViewCell
        // image
        cell.nameLabel.text = project.name
        cell.locationLabel.text = project.location.uppercased()
        cell.imageView.sd_setImage(with: FIRStorage.storage().reference(forURL: project.imageURL), placeholderImage: UIImage(named: "Arete.jpg"))
        cell.delegate = self
            cell.layoutSubviews()
        return cell
        } else {
            let cell = collectionContext!.dequeueReusableCell(of: VoteCell.self, for: self, at: index) as! VoteCell
            cell.upvoteButton.setTitle("+" + String(describing: project.upvotes), for: .normal)
            cell.downvoteButton.setTitle("-" + String(describing: project.downvotes), for: .normal)
            return cell
        }
    }
    
    func didUpdate(to object: Any) {
        project = object as? Project
    }
    
    func closeTapped() {
        delegate?.closeTapped()
    }
    
    func infoTapped() {
        delegate?.infoTapped()
    }
    
    func didSelectItem(at index: Int) {
        // nothing happens
    }
}

protocol ProjectCoverSectionControllerDelegate {
    func closeTapped()
    func infoTapped()
}
