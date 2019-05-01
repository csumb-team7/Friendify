//
//  LoginViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/8/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        //Validate user info
        let myDb = DB.init()
        myDb.signup(email: "test@csumb.edu", pass: "testadmin", success: { (response) in
            print("login")
        }) { (error) in
            print(error.localizedDescription)
        }
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    @IBAction func onSignup(_ sender: Any) {
    
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
