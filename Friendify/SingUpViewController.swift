//
//  SingUpViewController.swift
//  Friendify
//
//  Created by Mayra Ochoa on 4/22/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
 

class SingUpViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
    
        let username = usernameLabel.text
        let password = passwordLabel.text
        let email = emailLabel.text
        let name = nameLabel.text
        let myDb = DB.init()
        
        if (username?.characters.count != 0 && password?.characters.count != 0 && email?.characters.count != 0 && name?.characters.count != 0){
            errorLabel.isHidden = true
            myDb.signup(email: email!, pass: password!, success: { (response) in
                print("user created")
                self.usernameLabel.text = ""
                self.passwordLabel.text = ""
                self.emailLabel.text = ""
                self.nameLabel.text = ""
                
                //Log the user in
                myDb.login(email: email!, pass: password!, success: { (response) in
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    //Add data to the user
                    myDb.addUserInfo(data: ["name" : name!], success: { (response) in
                        self.errorLabel.isHidden = true;
                        //Perform the segue
                        self.performSegue(withIdentifier: "signupSegue", sender: nil)
                    }, failure: { (error) in
                        print("error data")
                        self.errorLabel.isHidden = false;
                        self.errorLabel.text = error
                    })
                }) { (error) in
                    print("error login")
                    self.errorLabel.isHidden = false;
                    self.errorLabel.text = error.localizedDescription
                }
            }) { (error) in
                print("error signup")
                self.errorLabel.isHidden = false
                self.errorLabel.text = error.localizedDescription
            }
            
        }else{
            errorLabel.isHidden = false
            errorLabel.text = "Please type username, email, password and name"
        }
        
        
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
