//
//  ReplyViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/3/6.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    var tweet: Tweet?
    
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvartar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAvartar.layer.cornerRadius = 5
        userAvartar.clipsToBounds = true
        
        let imageurl = URL(string: (tweet?.profilePictureUrl)!)
        userAvartar.setImageWith(imageurl!)
       
        userName.text = tweet?.name
        screenName.text = tweet?.screenName!
        
        replyTextView.becomeFirstResponder() //Appear a keyboard once view appear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onReply(_ sender: Any) {
        
        TwitterClient.sharedInstance?.reply(id: (tweet?.id)!, text: replyTextView.text!, success: { (response: Tweet) in
           self.dismiss(animated: true, completion: nil)
            
        }, failure: { (error: Error) in
            let alertController = UIAlertController(title: "Error", message: "Somethings wrong and I don't know too", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        })
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
