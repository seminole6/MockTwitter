//
//  ComposeViewController.swift
//  MockTwitter
//
//  Created by Devon Maguire on 3/6/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    var count: Int = 140

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(tweetTextView: UITextView) {
        count = 140 - tweetTextView.text.characters.count
        charCount.text = "\(count)"
    }
    
    @IBAction func onNewTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.composeTweet(tweetTextView.text!, success: { (tweets:[Tweet]) -> () in
            
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
