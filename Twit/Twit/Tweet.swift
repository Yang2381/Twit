//
//  Tweet.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timetamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profilePictureUrl: String?
    var name: String?
    var screenName: String?
    
    init(dictionary: NSDictionary) {
        
        
        text = dictionary["text"] as! String?
        retweetCount = (dictionary["retweet_count"] as! Int) 
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let user = dictionary.value(forKey: "user") as! NSDictionary
        profilePictureUrl = user.value(forKey: "profile_image_url_https") as! String?
        name = user.value(forKey: "name") as! String?
        screenName = user.value(forKey: "screen_name") as! String?
        let timestampSting = dictionary["created_at"] as? NSString
        if let timestampSting = timestampSting{
            let formatter =  DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timetamp = formatter.date(from: timestampSting as String) as NSDate?
        }
   
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
