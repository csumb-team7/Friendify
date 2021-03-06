//
//  HomeViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/17/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import AlamofireImage
import Foundation
import Firebase
import Siesta
import InstantSearchClient

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let myRefreshControl = UIRefreshControl()
    
    var songs = [NSDictionary]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        //let myDB = DB.init()
        //change for posts
        cell.usernameLabel.text = songs[indexPath.row]["name"] as? String
        cell.artistLabel.text = songs[indexPath.row]["singer"] as? String
        cell.songLabel.text = songs[indexPath.row]["title"] as? String
        cell.cap.text = songs[indexPath.row]["caption"] as? String
//        myDB.getUserById(name: ((Auth.auth().currentUser?.uid)!)) { (items) in
//            let str = items["name"]
//            cell.usernameLabel.text = (str as? String)
//        }
//        cell.songLabel.text = songs[indexPath.row]["name"] as? String
//        let idiv = (songs[indexPath.row]["album"] as! [String:Any])["images"] as! [[String:Any]]
//       //print( )
//        var artistName = ""
//        for artist in (songs[indexPath.row]["artists"] as? [[String : Any]])!{
//            artistName = artist["name"] as! String
//        }
//        cell.artistLabel.text = artistName as? String
//
//        var imageString = ""
//
//        /*for image in (songs[indexPath.row]["images"] as? [[String : Any]])!{
//            if(image["height"] as! String == "300"){
//                imageString = image["url"] as! String
//            }
//
        
        
        let userImageUrl = URL(string: songs[indexPath.row]["pic"] as! String)
       // cell.userImage.af_setImage(withURL: userImageUrl!)
       // let idiv = (songs[indexPath.row]["album"] as! [String:Any])["images"] as! [[String:Any]]
        //let songImageUrl = URL(string: idiv[0]["url"] as! String)
        cell.songImage.af_setImage(withURL: userImageUrl!)
        
        
        return cell
    }
    
    @objc func loadSongs(){
        let myDb = DB.init()
        myDb.getPosts(success: { (resp) in
            let response = resp
            self.songs.removeAll()
            for song in response {
                print(song)
                var item = [String:String]()
                item["name"] = song["authorName"] as? String
                item["singer"] = song["singer"] as? String
                item["title"] = song["title"] as? String
                item["caption"] = song["caption"] as? String
                item["pic"] = song["spotifyURI"] as? String
                self.songs.append(item as NSDictionary)

//                for artist in (song["artists"] as? [[String : Any]])!{
//                    print(artist["name"] as! String)
//                }
            }
             self.songs =  self.songs.reversed()
             self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
       
        self.myRefreshControl.endRefreshing()
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let myDb = DB.init()
        
        myRefreshControl.addTarget(self, action: #selector(loadSongs), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        /*myDb.getUserById(name: (Auth.auth().currentUser?.uid)!) { (list) in
            print(list["userToken"])
            DB.userToken = list["userToken"] as! String
        }*/
        
        myDb.getUserTopTracks(success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    
        loadSongs()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        print("Wazaaaaaaaa")
        
        tableView.dataSource = self
        tableView.delegate = self
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        /*let myDb = DB.init()
        
        myDb.getUserTopTracks(success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }*/
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "loggedIn")
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
