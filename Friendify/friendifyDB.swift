//
//  friendifyDB.swift
//  Friendify
//
//  Created by Luis Valencia on 4/8/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import Foundation
import Firebase
import Siesta

final class DB{
var db = Firestore.firestore();
let MyAPI = Service(baseURL: "https://accounts.spotify.com")
    init() {
        let client_id = "85b2a1f5241642e9829fed00296d330d";
        let client_secret = "61f17839ca8546abaddac04c21c4a209";
        let redirect_uri = "";
        let scopes = "user-read-private user-read-email user-read-recently-played user-top-read user-library-read"
        MyAPI.resource("/authorize")
    }
func getAllByType(name: String, result: @escaping ( _ response: [Dictionary<String, Any>]?) ->  Void){
    var response = [Dictionary<String, Any>]()
    db.collection(name).getDocuments(){(querySnapshot,err) in
        if let err = err {
            print( "Error getting documents:\(err)")
            result(nil)
        } else {
            for document in querySnapshot!.documents {
                 print("here")
                response.append(document.data())
            }
        }
        result(response)
    }
}

func getUserById(name: String, result: @escaping ( _ response: Dictionary<String, Any>?) ->  Void){
    
    let docRef = db.collection("users").document(name)
    
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
           // let dataDescription = //
            print("here")
            //document.data().map(String.init(describing:)) ?? "nil"
            result(document.data())
        } else {
            print("error")
            result(nil)
        }
    }
}


}
