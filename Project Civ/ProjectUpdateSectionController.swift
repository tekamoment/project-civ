//
//  ProjectUpdateSectionController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation
import IGListKit

class ProjectUpdateSectionController: IGListSectionController {
    var projectUpdate: ProjectUpdate!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension ProjectUpdateSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return projectUpdate.fetchUpdateComponents().count
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext, let update = projectUpdate else { return .zero }
        let width = context.containerSize.width
        
        // temp
        let components = projectUpdate.fetchUpdateComponents()
        if components[index] == .message {
            return TextCell.cellSize(width: width, string: update.message!)
        }
        return CGSize(width: width, height: 30)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let enumValue = projectUpdate.fetchUpdateComponents()[index]
        var cellClass: AnyClass
        
        switch enumValue {
        case .message:
            cellClass = TextCell.self
        case .date:
            cellClass = DateCell.self
            
        default:
            fatalError()
        }
        
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        
        if let cell = cell as? TextCell {
            cell.label.text = projectUpdate.message!
        } else if let cell = cell as? DateCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            cell.label.text = dateFormatter.string(from: projectUpdate.date) + " from " + projectUpdate.user.name
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        projectUpdate = object as? ProjectUpdate
    }
    
    func didSelectItem(at index: Int) {
        // fill this in
    }
}
