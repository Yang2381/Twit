//
//  TweetCell.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var ProfielPicture: UIImageView!
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    
    
    var tweet: Tweet!{

        willSet(tweet) {
            TextLabel.text = tweet.text!
            
            let imageURL = URL(string: tweet.profilePictureUrl!)
            ProfielPicture.setImageWith(imageURL!)
            
            userName.text = tweet.name
            screenName.text = "@\(tweet.screenName!)"
            retweetCount.text = self.convertcount(count: tweet.retweetCount)
            likeCount.text = "\(tweet.favoritesCount)"
                        
            
            let interval = Int(Date().timeIntervalSince(tweet.timetamp!))
            let timeInhours_minutes_seconds = convertSecondToDateAgo(seconds: interval)
            timeStamp.text = timeInhours_minutes_seconds
            
            if(tweet.favioriate == true ){
                likeImage.image = UIImage(named: "like")

            }else{
                likeImage.image = UIImage(named: "no-like")
            }
            
            if(tweet.retweeted == true){
                retweetImage.image = UIImage(named: "greentweet")

            }else{
                retweetImage.image = UIImage(named: "grayretweet")
            }
            
        }
       
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ProfielPicture.layer.cornerRadius = 5
        ProfielPicture.clipsToBounds = true
        
        likeImage.isUserInteractionEnabled = true
        retweetImage.isUserInteractionEnabled = true
        
      
        let TapRecognizerRetweet = UITapGestureRecognizer(target: self, action: #selector(self.TapRetweet(_sender:)))
        let TapRecognizerLike = UITapGestureRecognizer(target: self, action: #selector(self.TapLike(_sender:)))
        
        TapRecognizerRetweet.cancelsTouchesInView = true
        TapRecognizerLike.cancelsTouchesInView = true

    
        self.retweetImage.addGestureRecognizer(TapRecognizerRetweet)
        self.likeImage.addGestureRecognizer(TapRecognizerLike)
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   func TapRetweet(_sender: UITapGestureRecognizer){
        print("Tapped retweet")
        TwitterClient.sharedInstance?.retweet(id: tweet.id!, success: { (response: Tweet) in
            self.retweetImage.image = UIImage(named: "greentweet")
            self.retweetCount.text = "\(response.retweetCount)"
            self.tweet.retweetCount = response.retweetCount
            self.tweet.retweeted = true
            
        }, faliure: { (error: Error) in
            
        })
    }
    
    
    func TapLike(_sender: UITapGestureRecognizer){
        
        print("Tapped like")
        TwitterClient.sharedInstance?.favoriate(id: tweet.id!, success: { (response: Tweet) in
            self.likeImage.image = UIImage(named: "like")
            self.likeCount.text = self.convertcount(count: response.favoritesCount)
            self.tweet.favoritesCount = response.favoritesCount
            self.tweet.favioriate = true
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    /***************************************************************
     This portion of work is in direct reference from Liang
     Github: liang162
     This function is to convert the time since the start of current time.
    ****************************************************************/
    
    func convertSecondToDateAgo(seconds: Int)->String{
        var result: String?
        
        if (seconds/60 <= 59){
            result = "\(seconds/60)m"
        }else if (seconds/3600 <= 23){
            result = "\(seconds/3600)h"
        }else{
            result = "\(seconds/216000)d"
        }
        return result!
    }
    
    func convertCount(count: Int) -> String {
        var result: String?
        
        if(count/1000 >= 1 && count/1000 <= 100) {
            result = "\(count/1000) k"
        } else if(count/1000000 >= 1) {
            result = "\(count/1000000) m"
        } else {
            result = "\(count)"
        }
        
        return result!
    }
    
    func convertcount(count : Int) -> String{
        var result: String?
        
        if(count >= 1000 && count<=100){
            result = "\(count/1000)k"
        }else if(count > 100000 ){
            
           result = "\(count/10000)m"
        }else{
            result = "\(count)"
        }
        
        return result!
    }
}
