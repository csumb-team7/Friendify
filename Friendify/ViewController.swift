//
//  ViewController.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/6/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var display: UIWebView!
    override func viewDidLoad() {
        let myDB=DB.init()
        super.viewDidLoad()
        self.display.delegate = self;
        self.loadHtmlCode()
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("HELLO!")
        let myDB: DB = DB.init()
        let urlCodes = request.mainDocumentURL?.absoluteString
        if((urlCodes?.hasPrefix("https://google"))!){
            
            self.display.removeFromSuperview()
            DB.authToken = (urlCodes?.split(separator: "=")[1].description)!
            myDB.requestToken()
            return false;
        }
        return true
    }
    
    func loadHtmlCode() {
        // let url = string: st
        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/authorize?client_id=85b2a1f5241642e9829fed00296d330d&redirect_uri=https://google.com&response_type=code&scope=user-read-private%20user-read-email%20user-read-recently-played%20user-top-read%20user-library-read")!)
        request.httpMethod = "GET"
        
        self.display.loadRequest(request) //if your `webView` is `UIWebView`
        
    }
    
    
}


