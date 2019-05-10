//
//  LoginViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/8/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Siesta
import InstantSearchClient

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let myDb = DB.init()
        
        
        if UserDefaults.standard.bool(forKey: "loggedIn") == true{
            
            
            myDb.login(email: UserDefaults.standard.string(forKey: "username") ?? "", pass: UserDefaults.standard.string(forKey: "password") ?? "", success: { (str) in
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }) { (err) in
                print(err)
            }
            
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        //Validate user info
        let username = usernameTextField.text
        let password = passwordTextField.text
        let myDb = DB.init()
        
        
        if(username?.characters.count != 0 && password?.characters.count != 0){
            errorLabel.isHidden = true
            myDb.login(email: username!, pass: password!, success: { (response) in
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                UserDefaults.standard.set(true, forKey: "loggedIn")
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }) { (error) in
                self.errorLabel.isHidden = false;
                self.errorLabel.text = error.localizedDescription
            }
        }else{
            errorLabel.isHidden = false
            errorLabel.text = "Please type the email and the password"
        }
        /*
        
        myDb.signup(email: "test@csumb.edu", pass: "testadmin", success: { (response) in
            print("login")
        }) { (error) in
            print(error.localizedDescription)
        }
        */
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
