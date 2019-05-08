//
//  HomeViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/17/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        cell.usernameLabel.text = "Alexis Glez"
        cell.songLabel.text = "Con Calma"
        cell.artistLabel.text = "Daddy Yankee"
        
        let userImageUrl = URL(string: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-1/p160x160/56931933_2380876155270516_8463034650753761280_n.jpg?_nc_cat=102&_nc_ht=scontent-lax3-1.xx&oh=dec9f9903f6bd9fb1aaa1c5886ec7ab6&oe=5D3512BE")
        cell.userImage.af_setImage(withURL: userImageUrl!)
        
        let songImageUrl = URL(string: "https://i.ytimg.com/vi/0Q91ulV6gkE/maxresdefault.jpg")
        cell.songImage.af_setImage(withURL: songImageUrl!)
        
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let myDb = DB.init()
        
        myDb.getUserTopTracks(success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        print("Wazaaaaaaaa")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let myDb = DB.init()
        
        myDb.getUserTopTracks(success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
        //self.dismiss(animated: true, completion: nil)
        //UserDefaults.standard.set(false, forKey: "loggedIn")
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
