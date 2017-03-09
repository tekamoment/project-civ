//
//  Project.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation
import IGListKit

class Project: NSObject {
    let id: String //
    let imageURL: String
    let name: String //
    let holdingOffice: String //
    let longitude: Double //
    let latitude: Double //
    let location: String 
    let contactNumber: String //
    let cost: Double //
    let dateStarted: Date //
    let dateExpectedCompletion: Date //
    let projectDescription: String //
    var updates: [ProjectUpdate] = [ProjectUpdate]()
    var upvotes: Int //
    var downvotes: Int //
    
    init(id: String, imageURL: String, name: String, holdingOffice: String, longitude: Double, latitude: Double, location: String, contactNumber: String, cost: Double, dateStarted: Date, dateExpectedCompletion: Date, projectDescription: String, upvotes: Int, downvotes: Int) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.holdingOffice = holdingOffice
        self.longitude = longitude
        self.latitude = latitude
        self.location = location
        self.contactNumber = contactNumber
        self.cost = cost
        self.dateStarted = dateStarted
        self.dateExpectedCompletion = dateExpectedCompletion
        self.projectDescription = projectDescription
        self.upvotes = upvotes
        self.downvotes = downvotes
    }
    
    func costString() -> String {
        let costNumber = cost as NSNumber
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_PH")
        return formatter.string(from: costNumber)!
    }
}

class User: NSObject {
    let name: String
    let username: String?
    let imageURL: URL?
    
    init(name: String, username: String?, imageURL: URL?) {
        self.name = name
        self.username = username
        self.imageURL = imageURL
    }
}
