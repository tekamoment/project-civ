//
//  PostUpdateViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit

class PostUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // here
        dismiss(animated: true, completion: nil)
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
