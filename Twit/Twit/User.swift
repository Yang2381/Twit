//
//  User.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: NSString?
    var screenname: NSString?
    var profielURL: URL?
    var tagline: NSString?

    var dictionary: NSDictionary?
    
    //Initilizer
    init(dictionary: NSDictionary) {
       self.dictionary = dictionary
        
        name = dictionary["name"] as! NSString?
        screenname = dictionary["screen_name"] as! NSString?
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profielURL = URL(string: profileURLString)
        }
        
        tagline = dictionary["description"] as! NSString?
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get{
            
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                //Check if there is data in currentUser
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                //If there is!
                if let userData = userData {
                   let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    //Store it in the _currentUser
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
        
            if let user = user{
                //If user does exist store current user in json format in data
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else{
                //Store current user as nil
                defaults.removeObject(forKey: "currentUserData")
            }
        
            defaults.synchronize()
        }
    }
}
