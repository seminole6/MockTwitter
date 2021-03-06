//
//  TweetsViewController.swift
//  MockTwitter
//
//  Created by Devon Maguire on 2/28/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        
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
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
        
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
        } else if segue.identifier == "ReplySegue" {
            let button = sender as! UIButton
            let view = button.superview! as UIView
            let cell = view.superview as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let replyViewController = segue.destinationViewController as! ReplyViewController
            replyViewController.tweet = tweet
        }
        
    }

}
