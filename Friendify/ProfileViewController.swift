//
//  ProfileViewController.swift
//  Friendify
//
//  Created by Angel Vasquez on 4/24/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopTrackCell") as! TopTrackCell
        cell.songLabel.text = songs[indexPath.row]["name"] as? String
        var artistName = ""
        for artist in (songs[indexPath.row]["artists"] as? [[String : Any]])!{
            artistName = artist["name"] as! String
        }
        cell.artistLabel.text = artistName as? String
        let idiv = (songs[indexPath.row]["album"] as! [String:Any])["images"] as! [[String:Any]]
        let songImageUrl = URL(string: idiv[0]["url"] as! String)
        cell.songImage.af_setImage(withURL: songImageUrl!)
        
        
        
        
        
        return cell
    }
    


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var friendsNumLabel: UILabel!
    
    @IBOutlet weak var profileBioLabel: UILabel!
    
    var songs = [NSDictionary]()
    
    //@IBAction func linkAccount(_ sender: Any) {
      //  print("Hello")
                
    //}
    @IBAction func addButton(_ sender: Any) {
        let myDB = DB.init()
        myDB.getUserTopTracks(success: { (list) in
            print(list)
        }) { (str) in
            print(str)
        }
    }
    
    @IBAction func onEditProfile(_ sender: Any) {
        //Validate user info
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self as! UITableViewDelegate
        
        let myDB=DB.init()
        
        // Do any additional setup after loading the view.
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        profileName.text = "Friendify"
        friendsNumLabel.text = "20"
        
        profileBioLabel.text = "Friendify is a super cool app!"
        myDB.getUserTopTracks(success: { (response) in
            self.songs.removeAll()
            for song in response {
                self.songs.append(song)
                for artist in (song["artists"] as? [[String : Any]])!{
                    print(artist["name"] as! String)
                }
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
          }
        
        /*
        myDB.getUserById(name: ((Auth.auth().currentUser?.uid)!)) { (items) in
            print(items)
            var str = items["name"]
            var follow = items["followers"]
            self.friendsNumLabel.text = follow as? String
            self.profileName.text = str as! String
        }
        */

        
        
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
