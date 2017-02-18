//
//  ProjectInfoSectionController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import IGListKit

class ProjectInfoSectionController: IGListSectionController {
    var project: Project!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension ProjectInfoSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 3
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext, let project = project else { return .zero }
        let width = context.containerSize.width
        
        if index == 0 {
            return ProjectUpdateTitleCell.cellSize(width: width, titleString: project.holdingOffice, authorString: project.contactNumber)
        } else if index == 1 {
            return TextCell.cellSize(width: width, string: project.projectDescription)
        } else {
            return BoldTextCell.cellSize(width: width, string: "Cost: " + project.costString())
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        var cellClass: AnyClass
        
        switch index {
        case 0:
            cellClass = ProjectUpdateTitleCell.self
        case 1:
            cellClass = TextCell.self
        case 2:
            cellClass = BoldTextCell.self
        default:
            fatalError()
        }
        
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        
        if let cell = cell as? ProjectUpdateTitleCell {
            cell.titleLabel.text = project.holdingOffice
            cell.authorLabel.text = project.contactNumber
        } else if let cell = cell as? TextCell {
            cell.label.text = project.projectDescription
        } else if let cell = cell as? BoldTextCell {
            cell.label.text = "Cost: " + project.costString()
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        project = object as? Project
    }
    
    func didSelectItem(at index: Int) {
        // fill this in
    }
}
