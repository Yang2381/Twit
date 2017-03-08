//
//  ProfileViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/3/6.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profielImage: UIImageView!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        user = User.currentUser
        
        profielImage.layer.cornerRadius = 5
        profielImage.clipsToBounds = true
        
        profielImage.setImageWith((user?.profielURL)!)
        /*
        if let background = user?.backgroundURL {
            backgroundImage.setImageWith(background)
        }else{
            backgroundImage.image = backgroundImage.image!.withRenderingMode(.alwaysTemplate)
            backgroundImage.tintColor = UIColor.white
        }
        
        */
        screenName.text = (user?.screenname)! as String?
        userName.text = user?.name! as? String
        followerCount.text = "\(user!.follower!)"
        followingLabel.text = "\(user!.following!)"
        tweetCount.text = "\(user!.tweetsCount!)"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = User.currentUser
        
        profielImage.layer.cornerRadius = 5
        profielImage.clipsToBounds = true
        
        profielImage.setImageWith((user?.profielURL)!)
        
        screenName.text = (user?.screenname)! as String?
        userName.text = user?.name! as? String
        followerCount.text = "\(user!.follower!)"
        followingLabel.text = "\(user!.following!)"
        tweetCount.text = "\(user!.tweetsCount!)"

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
