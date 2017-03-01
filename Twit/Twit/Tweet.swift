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
    var timetamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profilePictureUrl: String?
    var name: String?
    var screenName: String?
    var id: Int?
    var favioriate: Bool?
    var retweeted: Bool?
    
    init(dictionary: NSDictionary) {
        
        id = dictionary["id"] as! Int?
        text = dictionary["text"] as! String?
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let user = dictionary.value(forKey: "user") as! NSDictionary
        profilePictureUrl = user.value(forKey: "profile_image_url_https") as! String?
        name = user.value(forKey: "name") as! String?
        screenName = user.value(forKey: "screen_name") as! String?
        
        retweeted = (dictionary["retweeted"] as? Bool )
        favioriate = (dictionary["favorited"] as? Bool)
        
        let timestampSting = dictionary["created_at"] as? String
        if let timestampSting = timestampSting{
            let formatter =  DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timetamp = formatter.date(from: timestampSting as String) as Date?
            
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
