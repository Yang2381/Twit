//
//  LoginViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

/*********************************************************************************************
 This place fetches token and guide user to authorize app to in safri or any browser

*********************************************************************************************/


import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager.init(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "3srGhuQMZH7TI7Gctrk8O6nbt", consumerSecret: "GBqydTgT6CIBWgTlZVKSmbLOZ3uaIK5V3ABdJFynsqzljLZZRT")
        
        //Logout first before request
        twitterClient?.deauthorize()
        
        //Get the token
        //twitterdemo is random string need to tell system to handle it
        //Handle it by go to Info > URL
        //callbackURL redirect it to twitterdemo://oauth
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken) in
            
            print("I got a token")
            
/*********************************************************************************************
            Open the url in iphone safari
            Add token into the url
            This is use for user to authroize in the safari
*********************************************************************************************/
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: { (success) in
                print("It can open")
            })
        }, failure: { (error: Error?) in
            print(error?.localizedDescription as Any)
        })
        
/*********************************************************************************************
         See code in AppDelegate
         That is once user authorized get the access code
         
*********************************************************************************************/
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
