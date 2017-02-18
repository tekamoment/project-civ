//
//  AddProjectViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/19/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import Eureka

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
            <<< ImageRow() {
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
        
        for (_, value) in form.values() {
            if value != nil {
                // present
                let alert = UIAlertController(title: "Unsaved changes", message: "Are you sure you want to leave? Your changes will not be saved.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Discard changes", style: .destructive, handler: { (_) in
                    self.presentingViewController!.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
            }
        }
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
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
        
        // else, push

    }
}

protocol AddProjectViewControllerDelegate {
    
}

