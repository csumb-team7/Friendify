//
//  ShareViewController.swift
//  Friendify
//
//  Created by user154365 on 5/13/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class ShareViewController: UIViewController {
    var song: [String:Any]!

    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    var artistName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        /*coverImage.layer.borderWidth = 1
        coverImage.layer.masksToBounds = false
        coverImage.layer.cornerRadius = coverImage.frame.height/2
        coverImage.clipsToBounds = true*/
        //Get Song information
        
        titleLabel.text = song["name"] as? String
        //var artistName = ""
        for artist in (song["artists"] as? [[String : Any]])!{
            artistName = artist["name"] as! String
        }
        artistLabel.text = artistName as? String
        let idiv = (song["album"] as! [String:Any])["images"] as! [[String:Any]]
        let songImageUrl = URL(string: idiv[0]["url"] as! String)
        coverImage.af_setImage(withURL: songImageUrl!)        // Do any additional setup after loading the view.*/
    }
    
    @IBAction func shareSong(_ sender: Any) {
        let myDB = DB.init()
        let cap = ":)"
        let type = ""
        guard let songtitle = song["name"] as? String else { return }
        let idiv = (song["album"] as! [String:Any])["images"] as! [[String:Any]]
        
        myDB.makePost(caption: cap, type: type, title: songtitle, singer: artistName, SpotifyURI: " ", success: { (items) in
            print("succes")
        }) { (error) in
            print("help")
        }
        
    }
}
