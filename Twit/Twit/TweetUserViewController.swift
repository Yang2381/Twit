//
//  TweetUserViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/3/6.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class TweetUserViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profielImage: UIImageView!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenName.text = "@\((user!.screenname!))"
        userName.text = User.currentUser!.name! as String?
        profielImage.setImageWith(user!.profielURL!)
        followerCount.text = "\(user!.follower!)"
        followingCount.text = "\(user!.following!)"
        tweetCount.text = "\(user!.tweetsCount!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
