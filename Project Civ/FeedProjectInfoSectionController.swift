//
//  FeedProjectInfoSectionController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import IGListKit
import QuartzCore
import FirebaseStorage
import FirebaseStorageUI

class FeedProjectInfoSectionController: IGListSectionController {
    var project: Project!
    var delegate: FeedProjectInfoSectionControllerDelegate?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension FeedProjectInfoSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 2
//        return 3
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext, let project = project else { return .zero }
        let width = context.containerSize.width
        
        if index == 0 {
            return CGSize(width: width, height: 200)
        } else {
            return TextCell.cellSize(width: width, string: project.projectDescription)
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
    
        var cellClass: AnyClass
        switch index {
        case 0:
            cellClass = ProjectNameLocationViewCell.self
        case 1:
            cellClass = TextCell.self
        default:
            fatalError()
        }
        
    
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        if let cell = cell as? ProjectNameLocationViewCell {            
            cell.imageView.sd_setImage(with: FIRStorage.storage().reference(forURL: project.imageURL), placeholderImage: UIImage(named: "Arete.jpg"))
            cell.nameLabel.text = project.name
            cell.locationLabel.text = project.location.uppercased()
            
        } else if let cell = cell as? TextCell {
            cell.label.text = project.projectDescription
        }
        return cell
    }
    
    func didUpdate(to object: Any) {
        project = object as? Project
    }
    
    func didSelectItem(at index: Int) {
        // present modally
        if (delegate != nil) {
            delegate?.projectSelected(project)
        }
    }
}

protocol FeedProjectInfoSectionControllerDelegate {
    func projectSelected(_ project: Project)
}
