//
//  ProfileViewController.swift
//  Friendify
//
//  Created by Angel Vasquez on 4/24/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var friendsNumLabel: UILabel!
    
    @IBOutlet weak var profileBioLabel: UILabel!
    
    @IBAction func onEditProfile(_ sender: Any) {
        //Validate user info
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        profileName.text = "Friendify"
        friendsNumLabel.text = "20"
        
        profileBioLabel.text = "Friendify is a super cool app!"
        
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
