//
//  TweetsViewController.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import AFNetworking


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tweets: [Tweet]!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        /*************************************************
         Add logo in the navigation bar
        *************************************************/
        let logoImage = UIImage(named: "title_View")
        
        let logoView = UIImageView(frame: CGRect(x:0,y:0,width:44,height:44))
        logoView.image = logoImage
        logoView.contentMode = .scaleAspectFit
        let titleView = UIImageView(frame: CGRect(x:0,y:0,width:44,height:44))
        logoView.frame = titleView.bounds
        titleView.addSubview(logoView)
        
        self.navigationItem.titleView = titleView
        //Get Timeline tweet and store it in tweets[]
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
            let alertController = UIAlertController(title: "Error", message: "Somethings wrong and I don't know too", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
           
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        cell.tweet  = tweets[indexPath.row]
        
        return cell
    }
  
    
    @IBAction func onLogoutButton(_ sender: Any) {
         TwitterClient.sharedInstance?.logout()
    }
   
    @IBAction func onPost(_ sender: Any) {
        performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController //With navigation controller have to do this 
        
        
        
        if segue.identifier == "detailSeguee"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets[indexPath!.row]

        let vc = navController.topViewController as! DetialViewController
        vc.tweet = tweet
        }
        
        
    }
    
  
}
