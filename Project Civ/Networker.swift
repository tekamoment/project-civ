//
//  Networker.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import Foundation
import Alamofire

class ProjectSource: NSObject {
    let sourceURL = "192.168.251.111:9999"
    
    static let sharedInstance = ProjectSource()
    fileprivate var projects: [Project]?
    fileprivate var longitude = Double()
    fileprivate var latitude = Double()
    
    override init() {
        super.init()
    }
    
    func fetchProjects(longitude: Double, latitude: Double, completion: @escaping(_ projects: [Project]?) -> Void) {
        guard projects != nil, self.longitude != longitude, self.latitude != latitude else {
            Alamofire.request(URL(string:"http://\(sourceURL)/project/viewallprojects")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Accept" : "application/json"]).responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error while fetching projects.")
                    return
                }
                
                guard let value = response.result.value as? [[String: Any]] else {
                    print("Malformed data received from viewallprojects service")
                    completion(nil)
                    return
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                
//                for array in value {
//                    for (key, value) in array {
//                        print("For key \(key) we have type \(Mirror(reflecting: value).subjectType)")
//                    }
//                }
//                
                let innerProjects = value.flatMap({ (dict) -> Project in
                    return Project(id: String(describing:(dict["id"] as? Int)!),
                                   imageURL: (dict["imageurl"] as? String)!,
                                   name: (dict["name"] as? String)!,
                                   holdingOffice: (dict["local_government_name"] as? String)!,
                                   longitude: Double((dict["longitude"] as? String)!)!,
                                   latitude: Double((dict["latitude"] as? String)!)!,
                                   location: (dict["local_government_name"] as? String)!,
                                   contactNumber: (dict["contact_number"] as? String)!,
                                   cost: Double((dict["cost"] as? String)!)!,
                                   dateStarted: formatter.date(from: (dict["date_started"] as? String)!)!,
                                   dateExpectedCompletion: formatter.date(from: (dict["deadline"] as? String)!)!,
                                   projectDescription: (dict["description"] as? String)!,
                                   upvotes: (dict["upvotes"] as? Int)!,
                                   downvotes: (dict["downvotes"] as? Int)!)
                })
                
                completion(innerProjects.reversed())
                
                
            }
            return
        }
    }
    
    func fetchUpdatesForProject(_ project: Project, completion: @escaping(_ projectUpdates: [ProjectUpdate]?) -> Void) {
        Alamofire.request(URL(string:"http://\(sourceURL)/project/updates")!, method: .get, parameters: ["projectID" : Int(project.id)!], encoding: URLEncoding.default, headers: ["Accept" : "application/json"]).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while fetching project updates.")
                print(response.error!)
                return
            }
            
            guard let value = response.result.value as? [[String: Any]] else {
                print("Malformed data received from updates service")
                completion(nil)
                return
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            for array in value {
                for (key, value) in array {
                    print("For key \(key) we have type \(Mirror(reflecting: value).subjectType) for \(value)")
                }
            }
            
            let projectUpdates = value.flatMap({ (dict) -> ProjectUpdate in
                return ProjectUpdate(project: project, user: User(name: (dict["poster"] as? String)!, username: nil, imageURL: nil), title: ((dict["title"] as? String)!), message: ((dict["description"] as? String)!), imageURL: nil,
                    date: formatter.date(from: ((dict["dateUploaded"] as? String)!))!)
            })
            

            completion(projectUpdates)
            
            
        }
        return
    }

    func postNewProject(project: Project, completion: @escaping () -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        let request = Alamofire.request(URL(string: "http://\(sourceURL)/project/new")!, method: .post, parameters:  ["name" : project.name, "local_government_name" : project.holdingOffice, "longitude" : String(project.longitude), "latitude" : String(project.latitude), "contact_number" : project.contactNumber, "cost" : String(project.cost), "date_started" : formatter.string(from: project.dateStarted), "deadline" : formatter.string(from: project.dateExpectedCompletion), "description" : project.projectDescription, "upvotes" : project.upvotes, "downvotes" : project.downvotes, "imageurl": project.imageURL], encoding: JSONEncoding.default, headers: ["Accept" : "application/json"])
        
//        request.validate()
        
        request.responseString { response in
            guard response.result.isSuccess else {
                print("Error while sending projects.")
                print(response.error)
                print(response.result.value)
                return
            }
            
            completion()
        }
    }
}
