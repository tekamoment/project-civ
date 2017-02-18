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

    let elijahURL = "10.101.11.143:9999/main/register"
    
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
        Alamofire.request(URL(string: "http://\(elijahURL)")!, method: .post, parameters: ["username" : "trial_user"], encoding: JSONEncoding.default, headers: ["Accept" : "application/json"]).responseJSON { response in
            print("URL requested: \(response.request!)")
            
            guard response.result.isSuccess else {
                print(response.result.error!)
                print(response.data!)
                print("Unable to request from Elijah API.")
                return
            }
            
            print("JSON returns: \(response.result.value!)")
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
