//
//  TimeLineViewController.swift
//  MockTwitter
//
//  Created by Devon Maguire on 3/6/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    var screenname: String!
    var tweet: Tweet!
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.userTimeLine(screenname, success: { (tweets:[Tweet]) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        
        usernameLabel.text = tweet.name! as String
        
        let profilePath = tweet.profileUrl
        if let profilePath = profilePath {
            profileImageView.setImageWithURL(NSURL(string: profilePath)!)
        }
        let backProfilePath = tweet.backUrl
        if let backProfilePath = backProfilePath {
            backImageView.setImageWithURL(NSURL(string: backProfilePath)!)
        }
        
        followCountLabel.text = "\(tweet.followCount)"
        followerCountLabel.text = "\(tweet.followerCount)"
        tweetCountLabel.text = "\(tweet.tweetCount)"
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
