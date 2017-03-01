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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var ProfielPicture: UIImageView!
    
    
    var tweet: Tweet!{
        willSet{
            TextLabel.text = tweet.text!
            let imageURL = URL(string: tweet.profilePictureUrl!)
            ProfielPicture.setImageWith(imageURL!)
            userName.text = tweet.name
            screenName.text = "@\(tweet.screenName!)"
            
            let interval = Int(Date().timeIntervalSince(tweet.timetamp!))
            let timeInhours_minutes_seconds = convertSecondToDateAgo(seconds: interval)
            timeStamp.text = timeInhours_minutes_seconds
            
            if(tweet.favioriate == true ){
                likeButton.setImage(UIImage(named: "like"), for: UIControlState.normal)

            }else{
                likeButton.setImage(UIImage(named: "no-like"), for: UIControlState.normal)
            }
            
            if(tweet.retweeted == true){
                retweetButton.setImage(UIImage(named: "greenretweet"), for: UIControlState.normal)

            }else{
                retweetButton.setImage(UIImage(named: "grayretweet"), for: UIControlState.normal)
            }
            
        }
        didSet{
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ProfielPicture.layer.cornerRadius = 5
        ProfielPicture.clipsToBounds = true
        
        let TapRecognizerRetweet = UITapGestureRecognizer(target: self, action: #selector(TweetCell.TapRetweet(_:)))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func TapRetweet(_sender: Any){
        
        TwitterClient.sharedInstance?.retweet(id: tweet.id!, success: { (response: Tweet) in
             self.retweetButton.setImage(UIImage(named: "greenretweet"), for: UIControlState.normal)
             self.retweetCount.text = self.convertCount(count: response.retweetCount)
            self.tweet.retweetCount = response.retweetCount
            self.tweet.retweeted = true
        }, faliure: { (error: Error) in
            
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
}
