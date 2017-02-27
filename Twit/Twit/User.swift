//
//  User.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var profielURL: NSURL?
    var tagline: NSString?

    //Initilizer
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as! NSString?
        screenname = dictionary["screen_name"] as! NSString?
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profielURL = NSURL(string: profileURLString)
        }
        
        tagline = dictionary["description"] as! NSString?
    }
    
    class var currentUser: User? {
        get{
            return nil
        }
    }
}
