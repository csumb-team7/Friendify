//
//  ViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/6/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var name = ""
        
        //  Get all objects by data type ie users, posts
//        getAllByType(name: "users") { (result: [Dictionary<String, Any>]?) in
//            print(result)
//        }
        
        // Get a single user object by its ID
        getUserById(name: "vUbfv6PbROoGzOxRd2ch") { (result: Dictionary<String, Any>?) in
            var data = Dictionary<String, Any>()
            data = result ?? [:]
            name = data["name"] as! String
            print(data["name"]!)
            print("in function " + name)
            
        }
        print("out")
        
        
        print("here" + name)
        
     
        // Do any additional setup after loading the view, typically from a nib.
    }


}

