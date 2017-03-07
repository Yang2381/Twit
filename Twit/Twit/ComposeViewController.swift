//
//  ComposeViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/3/6.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var textFiled: UITextView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenName.text = User.currentUser?.screenname as String?
        userName.text = User.currentUser?.name as String?
        profileImage.setImageWith((User.currentUser?.profielURL)!)
        textFiled.becomeFirstResponder()
    }
    @IBAction func onPost(_ sender: Any) {
        TwitterClient.sharedInstance?.postTweet(text: textFiled.text!,success: { (response: Tweet) in
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error: Error) in
            let alertController = UIAlertController(title: "Error", message: "Somethings wrong and I don't know too", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
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
