//
//  ProjectUpdate.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation
import IGListKit

class ProjectUpdate: NSObject {
    weak var project: Project?
    let user: User
    let title: String
    let message: String?
    let imageURL: URL?
    let date: Date
    // let reporter: User
    init(project: Project, user: User, title: String, message: String?, imageURL: URL?, date: Date) {
        self.project = project
        self.user = user
        self.title = title
        self.message = message
        self.imageURL = imageURL
        self.date = date
    }
    
    func fetchUpdateComponents() -> [UpdateComponents] {
//        var updateComponents: [UpdateComponents] = [.userInfo]
//        if (imageURL != nil) { updateComponents.append(.image) }
        
        // temp
        var updateComponents = [UpdateComponents]()
        
        updateComponents.append(.userInfoAndTitle)
        if (imageURL != nil) { updateComponents.append(.image) }
        if (message != nil) { updateComponents.append(.message) }
//        updateComponents.append(.date)
        return updateComponents
    }
}

enum UpdateComponents {
    case userInfoAndTitle
    case message
    case image
    case date
}
