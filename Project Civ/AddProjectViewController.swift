//
//  AddProjectViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

import Firebase

class AddProjectViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = super.tableView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        navigationItem.setCustomTitleView(title: "NEW PROJECT")
        
        form = Form()
        
        form +++ Section()
            <<< TextRow("Name") {
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            +++ Section()
            <<< DateRow("DateStarted") {
                $0.title = "Date Started"
                $0.add(rule: RuleRequired())
                $0.maximumDate = Date()
                $0.validationOptions = .validatesOnChange
                }.cellUpdate { cell, row in
                    if !row.isValid && row.value == nil {
                        print("DateStarted is invalid")
                        cell.textLabel?.textColor = .red
                    }
            }.onChange({ (row) in
                let expectedCompletionRow: DateRow! = self.form.rowBy(tag: "DateExpectedCompletion") as! DateRow
                expectedCompletionRow.minimumDate = (row.value) ?? nil
            })
            <<< DateRow("DateExpectedCompletion") {
                $0.title = "Expected Completion"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate { cell, row in
                    if !row.isValid && row.value == nil {
                        print("DateExpectedCompletion is invalid")
                        cell.textLabel?.textColor = .red
                    }
            }
            +++ Section()
            <<< TextRow("LocalGovernment") {
                $0.title = "Govt. Office"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            // add map here
            <<< LocationRow("Location") {
                $0.title = "Location"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            <<< PushRow<String>("City") {
                $0.title = "City"
                $0.selectorTitle = "Pick the city"
                $0.options = ["Quezon City", "Manila", "Makati", "Marikina"].sorted()
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            <<< PhoneRow("ContactNumber") {
                $0.title = "Project Contact Number"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< DecimalRow("Cost") {
                $0.title = "Estimated Cost"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            +++ Section()
            <<< ImageRow("Image") {
                $0.title = "Image"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            <<< TextAreaRow("ProjectDescription") {
                $0.placeholder = "Describe this project"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.placeholderLabel.textColor = .red
                    }
        }
    }
    
    func cancelTapped() {
        let valuesDictionary = form.values()
        print(valuesDictionary)
        
        var allClear = true
        
        for (_, value) in form.values() {
            if value != nil {
                // present
                allClear = false
                let alert = UIAlertController(title: "Unsaved changes", message: "Are you sure you want to leave? Your changes will not be saved.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Discard changes", style: .destructive, handler: { (_) in
                    self.presentingViewController!.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                break
            }
        }
        
        if allClear {
            self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
    }
    
    func doneTapped() {
        let valuesDictionary = form.values()
        print(valuesDictionary)
        
        for (_, value) in form.values() {
            if value == nil {
                // present
                let alert = UIAlertController(title: "Missing data", message: "All fields need to be filled in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
            }
        }
        
        let progressView = UIProgressView(frame: view.bounds)
        view.addSubview(progressView)
        
        let location = (self.form.rowBy(tag: "Location") as! LocationRow).value! as CLLocation
        
        let storageRef = FIRStorage.storage().reference()
        let locationRef = storageRef.child("images/\(location.coordinate.longitude)+\(location.coordinate.latitude).jpg")
        
        let image = (self.form.rowBy(tag: "Image") as! ImageRow).value!
        
        let data = UIImageJPEGRepresentation(image, 0.8)!
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpg"
        locationRef.put(data, metadata: metadata){(metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                //store downloadURL
//                let downloadURL = metadata!.downloadURL()!.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let downloadURL = metadata!.downloadURL()!.absoluteString
                print(downloadURL)
                //store downloadURL at database
                
                let proj = Project(id: "0", imageURL: downloadURL, name: (self.form.rowBy(tag: "Name") as! TextRow).value!, holdingOffice: (self.form.rowBy(tag: "LocalGovernment") as! TextRow).value!, longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, location: (self.form.rowBy(tag: "City") as! PushRow<String>).value!, contactNumber: (self.form.rowBy(tag: "ContactNumber") as! PhoneRow).value!, cost: (self.form.rowBy(tag: "Cost") as! DecimalRow).value!, dateStarted: (self.form.rowBy(tag: "DateStarted") as! DateRow).value!, dateExpectedCompletion: (self.form.rowBy(tag: "DateExpectedCompletion") as! DateRow).value!, projectDescription: (self.form.rowBy(tag: "ProjectDescription") as! TextAreaRow).value!, upvotes: 0, downvotes: 0)
                ProjectSource.sharedInstance.postNewProject(project: proj) {
                    print("Posted successfully.")
                    progressView.removeFromSuperview()
                    self.presentingViewController!.dismiss(animated: true, completion: nil)
                }
                
//                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
            }
            
        }
        
        
        // else, push
    }
}

protocol AddProjectViewControllerDelegate {
    
}

