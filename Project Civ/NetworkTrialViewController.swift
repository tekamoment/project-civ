//
//  NetworkTrialViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTrialViewController: UIViewController {

    let elijahURL = "10.101.15.46:9999/project/viewallprojects"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testNetworkPressed(_ sender: Any) {
        print("http://\(elijahURL)")
        ProjectSource.sharedInstance.fetchProjects(longitude: 10.0, latitude: 10.0) { (projects) in
            print(projects!)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
