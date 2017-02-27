//
//  TwitterClient.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
   
    //Static means can't be overwritten
   static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "3srGhuQMZH7TI7Gctrk8O6nbt", consumerSecret: "GBqydTgT6CIBWgTlZVKSmbLOZ3uaIK5V3ABdJFynsqzljLZZRT")
    
    var loginSucess: (() -> ())?
    var loginfailure: ((NSError) -> ())?
    
     /*********************************************************************************************
       This function is use for login
         -Fetch token 
         -Ask user to authorize in Safari
      Note: Login parameeter can use for completion handle. Checkout in LoginViewController
     *********************************************************************************************/
    func login(success: @escaping ()-> (), failure: @escaping (NSError) -> ())  {
        
        //Store success Or error in these variables
        loginSucess = success
        loginfailure = failure
        
        //Logout first before request
        TwitterClient.sharedInstance?.deauthorize()
        
         /*********************************************************************************************
          Get the token
          twitterdemo is random string need to tell system to handle it
          Handle it by go to Info > URL
          callbackURL redirect it to twitterdemo://oauth
         *********************************************************************************************/
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken) in
            
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
            //Pass the error to loginfailure
            self.loginfailure?(error as! NSError)
        })
        
        /*********************************************************************************************
         See code in AppDelegate
         That is once user authorized get the access code
         
         *********************************************************************************************/
    }
    
    func logout()  {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handlOpenUrl(url: NSURL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
           
            self.currentAccount(success: { (user: User) in
               //Call setter and save currentUser
                User.currentUser = user
                self.loginSucess?()
            }, failure: { (error: NSError) in
                self.loginfailure?(error)
            })
            
        }, failure: { (error: Error?) in
            self.loginfailure?(error as! NSError)
        })

    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) in
            
            //Cast stored json response in response into dictionary in user
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            
            success(user)
           
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
        
    }

    
    
    
}
