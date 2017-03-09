//
//  StaticProjectUpdateLoader.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation

class StaticDataLoader {
    var updates = [ProjectUpdate]()
    var projects = [Project]()
    
    func load() {
        let user1 = User(name: "Max Abella", username: "mabella", imageURL: nil)
        let user2 = User(name: "Sara Velasco", username: "saravelasco", imageURL: nil)
        
        let projectA = Project(id: "1", imageURL: "hello", name: "Areté", holdingOffice: "Ateneo de Manila University", longitude: 121.075597, latitude: 14.641354, location: "Quezon City, Philippines", contactNumber: "(02) 426-6001", cost: 50000000.00, dateStarted: Date(timeIntervalSince1970:1433131200), dateExpectedCompletion: Date(timeIntervalSince1970: 1496289600), projectDescription: "A place where we hope to carry on the integral formation of Ateneans in the Jesuit tradition...", upvotes: 220, downvotes: 10)
        
        
        updates.append(ProjectUpdate(project: projectA, user: user1, title: "Reassuring progress", message: "Areté seems to be on schedule", imageURL: URL(string: "http://facebook.com/"), date: Date()))
        updates.append(ProjectUpdate(project: projectA, user: user2, title: "New developments", message: "Back painting of Areté has commenced", imageURL: nil, date: Date()))
        
        projectA.updates += updates
        
        projects.append(projectA)
        
        
    }
}
