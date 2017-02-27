//
//  Tweet.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timetamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as! NSString?
        
        //?? Means if it does not exist use 0 instead
        retweetCount = (dictionary["retweet_count"] as! Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        
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
