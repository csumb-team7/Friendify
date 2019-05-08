//
//  LinkAccountViewController.swift
//  Friendify
//
//  Created by Angel Vasquez on 5/6/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit
import WebKit

class LinkAccountViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var display: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myDB=DB.init()
        super.viewDidLoad()
        self.display.delegate = self;
        loadHtmlCode()

        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let myDB: DB = DB.init()
        let urlCodes = request.mainDocumentURL?.absoluteString
        if((urlCodes?.hasPrefix("https://google"))!){
            self.display.removeFromSuperview()
            myDB.authToken = (urlCodes?.split(separator: "=")[1].description)!
            myDB.requestToken()
            if(myDB.authToken != "")
            {
                //self.performSegue(withIdentifier: "backToProfile", sender: self)
                self.dismiss(animated: true, completion: nil)
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
