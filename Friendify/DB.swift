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
import InstantSearchClient

final class DB{
    
    var db: Firestore
    var authToken: String;
    var userToken: String;
    let MyAPI = Service(baseURL: "https://api.spotify.com/v1/")
    let client_id = "85b2a1f5241642e9829fed00296d330d";
    let client_secret = "61f17839ca8546abaddac04c21c4a209";
    var authProcess: Resource
    let client = Client(appID: "XSLL75CT90", apiKey: "f788a429f403bee75ffd22e88e2a24a7")
    let index: Index
    init() {
        //FirebaseApp.configure()
        db = Firestore.firestore()
        let client = Client(appID: "XSLL75CT90", apiKey: "f788a429f403bee75ffd22e88e2a24a7")
        index = client.index(withName: "users")
        
        authToken=""
        userToken=""
        
        self.authProcess = self.MyAPI.resource(absoluteURL: "https://accounts.spotify.com/api/token")
        
    }
    
    func signup(email:String, pass: String, success:  @escaping(String) -> (), failure: @escaping (Error) -> ()){
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            guard let authResult = authResult, error == nil else {
                failure(error!)
                return
            }
            let uid = Auth.auth().currentUser?.uid
            self.db.collection("timeline").document(uid!).setData(["timeline": [Any]()])
            self.db.collection("posts").document(uid!).setData(["posts": [Any]()])
            
            success("\(authResult.user.email!) created")
            
        }
    }
    
    func login(email:String, pass: String, success:  @escaping(String) -> (), failure: @escaping (Error) -> ()){
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
            if let error = error {
                failure(error)
                return
            }
            success("\(String(describing: user?.user.uid)) logged in")
        }
    }
    
    func makePost(caption: String, type: String, SpotifyURI: String, success: @escaping(String) -> (), failure: @escaping (String) -> ()){
        if(Auth.auth().currentUser == nil){
            failure("User not logged!")
        } else {
            let uid = Auth.auth().currentUser?.uid
            let ref = db.collection("users").document(uid!)
            var data = [String:Any]()
            data["author"] = uid
            data["authorName"] = "Luis Valencia"
            data["caption"] = caption
            data["type"] = type
            data["spotifyURI"] = SpotifyURI
            data["timestamp"] = Timestamp(date: Date())
            
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                        print(document.data()!)
                        for person in document.data()!["followers"] as! [String] {
                            
                            let tempRef = self.db.collection("timeline").document(person)
                            transaction.updateData(["timeline" : FieldValue.arrayUnion([data])], forDocument: tempRef)
                        }
                        transaction.updateData(["posts" : FieldValue.arrayUnion([data])], forDocument: self.db.collection("posts").document(uid!))
                        return nil
                    })
                    { (object, error) in
                        if let error = error {
                            failure("Transaction failed: \(error)")
                        } else {
                            success("Post successfully written!")
                        }
                    }
                }  else {
                    print("error")
                    
                }
            }
        }
    }
    func addFriend(id: String, success: @escaping(String) -> (), failure: @escaping (String) -> ()) {
        
        if(Auth.auth().currentUser == nil){
            failure("User not logged!")
        } else {
            let uid = Auth.auth().currentUser?.uid
            let userRef = db.collection("users").document(uid!)
            let friendRef = db.collection("users").document(id)
            db.runTransaction({ (transaction, errorPointer) -> Any? in
                transaction.updateData(["following" : FieldValue.arrayUnion([id]),
                                        "followingCount": FieldValue.increment(1.0)], forDocument: userRef)
                transaction.updateData(["followers" : FieldValue.arrayUnion([uid!]),
                                        "followerCount": FieldValue.increment(1.0)], forDocument: friendRef)
                return nil
            }) { (object, error) in
                if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                }
            }
        }
    }
    func removeFriend(id: String, success: @escaping(String) -> (), failure: @escaping (String) -> ()) {
        if(Auth.auth().currentUser == nil){
            failure("User not logged!")
        } else {
            
            let uid = Auth.auth().currentUser?.uid
            let userRef = db.collection("users").document(uid!)
            let friendRef = db.collection("users").document(id)
            
            db.runTransaction({ (transaction, errorPointer) -> Any? in
                transaction.updateData(["following" : FieldValue.arrayRemove([id]),
                                        "followingCount": FieldValue.increment(-1.0)], forDocument: userRef)
                transaction.updateData(["followers" : FieldValue.arrayRemove([uid!]),
                                        "followerCount": FieldValue.increment(-1.0)], forDocument: friendRef)
                return nil
            }) { (object, error) in
                if let error = error {
                    failure("Transaction failed: \(error)")
                } else {
                    success("Transaction successfully committed!")
                }
                
            }
        }
    }
    func getPosts(success: @escaping ([String: Any])->(), failure: @escaping (String) ->()){
        if(Auth.auth().currentUser == nil){
            failure("User not logged!")
        } else {
            
            let uid = Auth.auth().currentUser?.uid
            let docRef = db.collection("timeline").document(uid!)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    success(document.data()!)
                } else {
                    print("error")
                    failure("Something went wrong \(error)")
                }
            }
            
            
        }
    }
    func addUserInfo(data: [String: Any],success:  @escaping(String) -> (), failure: @escaping (String) -> ()){
        if(Auth.auth().currentUser == nil){
            failure("User not logged!")
        } else {
            var userData = [String:Any]()
            let uid = Auth.auth().currentUser?.uid
            let ref = db.collection("users").document(uid!)
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            let name = data["name"] as? String ?? "";
            if (name != ""){
                changeRequest?.displayName = name
                changeRequest?.commitChanges { (error) in
                    print(error?.localizedDescription)
                    return
                }
            }
            
            userData["objectID"] = uid
            userData["following"] = [String]()
            userData["followers"] = [String]()
            userData["followingCount"] = 0
            userData["followerCount"] = 0
            userData.merge(data){ (current, _) in current }
            ref.setData(userData) {err in
                if let err = err {
                    failure("Error writing user data: \(err)")
                } else {
                    
                    self.index.partialUpdateObject(userData, withID: uid!)
                    success("User data successfully written!")
                }
            }
        }
    }
    
    
    
    func searchUsers(keyword: String,success:  @escaping(String) -> (), failure: @escaping (String) -> ()){
        let index = client.index(withName: "users")
        let query = Query(query: keyword)
        query.attributesToRetrieve = ["name", "objectID"]
        query.hitsPerPage = 50
        index.search(query, completionHandler: { (content, error) -> Void in
            if error == nil {
                success("Result: \(content!["hits"])")
            }
            else {
                failure(error!.localizedDescription)
            }
        })
    }
    func requestToken(){
        print(authToken)
        let postData = NSMutableData(data: "client_id=85b2a1f5241642e9829fed00296d330d".data(using: String.Encoding.utf8)!)
        postData.append("&client_secret=61f17839ca8546abaddac04c21c4a209".data(using: String.Encoding.utf8)!)
        postData.append("&grant_type=authorization_code".data(using: String.Encoding.utf8)!)
        postData.append(("&code="+authToken).data(using: String.Encoding.utf8)!)
        postData.append("&redirect_uri=https://google.com".data(using: String.Encoding.utf8)!)
        authProcess.request(.post, data: postData as Data, contentType: "application/x-www-form-urlencoded" )
            .onSuccess{data in
                print(data.jsonDict)
                self.authProcess.overrideLocalContent(with: data.jsonDict)
            }
            .onFailure{error in
                print (error)
        }
        
        authProcess.addObserver(owner: self) {
            [weak self] resource, event in
            print("In OBSERVER")
            //print(event)
            //print(resource.latestData)
            if case .newData = event{
                self?.userToken = resource.latestData!.jsonDict["access_token"] as! String
                //self?.getUserData()
            }
        }
    }
    
    func getUserTopTracks(success: @escaping([Any]) -> (), failure: @escaping (String) -> ()){
        if(self.userToken == ""){
            failure("Error. Spotify not linked yet")
            return
        }
        MyAPI.configure("me/top/tracks") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        MyAPI.configure("me/top/artists") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        let getStuff = self.MyAPI.resource("me/top/tracks")
        getStuff.request(.get, urlEncoded: [:])
            .onSuccess{data in
                print("inOnSuccess")
                //print(data.jsonDict["items"])
                let dic: [ Any] = data.jsonDict["items"] as! [Any]
                
                success(dic)
                //self.get.overrideLocalContent(with: data.jsonDict)
            } .onFailure{error in
                
                failure("Error: " + error.localizedDescription)
        }
    }
    func getUserTopArtists(success: @escaping([Any]) -> (), failure: @escaping (String) -> ()){
        if(self.userToken == ""){
            failure("Error. Spotify not linked yet")
            return
        }
        MyAPI.configure("me/top/tracks") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        MyAPI.configure("me/top/artists") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        let getStuff = self.MyAPI.resource("me/top/artists")
        getStuff.request(.get, urlEncoded: [:])
            .onSuccess{data in
                print("inOnSuccess")
                //print(data.jsonDict["items"])
                let dic: [ Any] = data.jsonDict["items"] as! [Any]
                
                success(dic)
                //self.get.overrideLocalContent(with: data.jsonDict)
            } .onFailure{error in
                
                failure("Error: " + error.localizedDescription)
        }
    }
    func getSongBySpotifyURI(uri:String,success: @escaping([String:Any]) -> (), failure: @escaping (String) -> () ){
        if(self.userToken == ""){
            failure("Error. Spotify not linked yet")
            return
        }
        MyAPI.configure("tracks") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        let getStuff = self.MyAPI.resource("tracks")
        getStuff.request(.get, urlEncoded: [:])
            .onSuccess{data in
                print("inOnSuccess")
                //print(data.jsonDict["items"])
                let dic: [String:Any] = data.jsonDict["items"] as! [String:Any]
                
                success(dic)
                //self.get.overrideLocalContent(with: data.jsonDict)
            } .onFailure{error in
                
                failure("Error: " + error.localizedDescription)
        }
    }
    func getSpotifyUserData(success: @escaping([String:String]) -> (), failure: @escaping (String) -> ()){
        
        MyAPI.configure("/me") {
            $0.headers["Authorization"] = "Bearer "+self.userToken
        }
        
        let getStuff = self.MyAPI.resource("me")
        getStuff.request(.get, urlEncoded: [:])
            .onSuccess{data in
                print("inOnSuccess")
                print(data.jsonDict)
                let dic: [ String:String] = data.jsonDict as! [String:String]
                success(dic)
                //                print(dic["id"])
                
                //self.get.overrideLocalContent(with: data.jsonDict)
            } .onFailure{error in
                
                failure("Error: " + error.localizedDescription)
        }
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
