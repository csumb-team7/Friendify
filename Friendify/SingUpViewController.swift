//
//  SingUpViewController.swift
//  Friendify
//
//  Created by Mayra Ochoa on 4/22/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import Parse

class SingUpViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        /*let user = PFUser()
        user.username = usernameLabel.text
        user.password = passwordLabel.text
        user.email = emailLabel.text
        //user.name = nameLabel.text
        
        user.signUpInBackground { (success, error) in
            
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                 print("Error: \(error?.localizedDescription)")
            }
            
        }*/
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
