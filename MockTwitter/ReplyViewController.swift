//
//  ReplyViewController.swift
//  MockTwitter
//
//  Created by Devon Maguire on 3/6/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    @IBOutlet weak var replyToLabel: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        replyToLabel.text = "In reply to \(tweet.name!)"
        replyTextView.text = "@\(tweet.screenname!) "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
        // add reply
        let tweetId = String(tweet.tweetId)
        TwitterClient.sharedInstance.replyToTweet(replyTextView.text!, userId: tweetId, success: { (tweets:[Tweet]) -> () in
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        navigationController?.popViewControllerAnimated(true)
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
