//
//  DetialViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/3/5.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import AFNetworking

class DetialViewController: UIViewController{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var userAvartar: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
   
    var tweet: Tweet?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAvartar.layer.cornerRadius = 5
        userAvartar.clipsToBounds = true
        
        
        let imageURL = URL(string: (tweet?.profilePictureUrl)!)
        userAvartar.setImageWith(imageURL!)
        
        userName.text = tweet?.name
        textMessage.text = tweet?.text
        
        screenName.text = "@\(tweet!.screenName!)"
        timeStamp.text = "\(tweet!.timetamp!)"
        retweetCount.text = "\(tweet!.retweetCount)"
        likeCount.text = "\(tweet!.favoritesCount)"
        
        if (tweet!.favioriate == true){
            likeImage.image = UIImage(named: "like")
        }else{
            likeImage.image = UIImage(named: "no-like")
        }
        
        if(tweet!.retweeted == true){
            retweetImage.image = UIImage(named: "greentweet")
        }else{
            retweetImage.image = UIImage(named: "grayretweet")
        }
        
        let TapRecognizerRetweet = UITapGestureRecognizer(target: self, action: #selector(self.onTapRetweet(_sender:)))
        let TapRecognizerLike = UITapGestureRecognizer(target: self, action: #selector(self.onTaplike(_sender:)))
       
        
        TapRecognizerRetweet.cancelsTouchesInView = true
        TapRecognizerLike.cancelsTouchesInView = true
       
        retweetImage.isUserInteractionEnabled = true
        likeImage.isUserInteractionEnabled = true 
      
        
        self.retweetImage.addGestureRecognizer(TapRecognizerRetweet)
        self.likeImage.addGestureRecognizer(TapRecognizerLike)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onReply(_ sender: Any) {
        performSegue(withIdentifier: "replySegue", sender: nil)
    }
    
    func onTapRetweet(_sender: Any){
        print("Tapped retweet")
        TwitterClient.sharedInstance?.retweet(id: tweet!.id!, success: { (response: Tweet) in
            self.retweetImage.image = UIImage(named: "greentweet")
            self.retweetCount.text = "\(response.retweetCount)"
            self.tweet?.retweetCount = response.retweetCount
            self.tweet?.retweeted = true
            
        }, faliure: { (error: Error) in
            TwitterClient.sharedInstance?.unretweet(id: self.tweet!.id!, success: { (response: Tweet) in
                self.retweetImage.image = UIImage(named: "grayretweet")
                self.retweetCount.text = "\(response.retweetCount - 1)"
                self.tweet?.retweetCount = response.retweetCount
                self.tweet?.retweeted = false
            }, failure: { (error: Error) in
                
            })
        })
    }
    
    func onTaplike(_sender: Any){
        
        print("Tapped like")
        TwitterClient.sharedInstance?.favoriate(id: tweet!.id!, success: { (response: Tweet) in
            self.likeImage.image = UIImage(named: "like")
            self.likeCount.text = self.convertCount(count: response.favoritesCount)
            self.tweet?.favoritesCount = response.favoritesCount
            self.tweet?.favioriate = true
            
        }, failure: { (error: Error) in
            TwitterClient.sharedInstance?.unfavoriate(id: self.tweet!.id!, success: { (response: Tweet) in
                self.likeImage.image = UIImage(named: "no-like")
                self.likeCount.text = "\(response.favoritesCount-1)"
                self.tweet?.favoritesCount = response.favoritesCount
                self.tweet?.favioriate = false
            }, failure: { (error: NSError) in
                
            })
        })
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //ReplyView is under navigation so instatiate navgation first
        let navController = segue.destination as! UINavigationController
        if segue.identifier == "replySegue"{
            let replyController = navController.topViewController as! ReplyViewController
            replyController.tweet = self .tweet
        }else if segue.identifier == "tweetDetail"{
            let detailController = navController.topViewController as! TweetUserViewController
            detailController.user = self.tweet?.tweetUser
            
            
        }
        
        
        
    }
    

}
