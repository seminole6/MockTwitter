//
//  DetailViewController.swift
//  MockTwitter
//
//  Created by Devon Maguire on 3/5/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = tweet.name! as String
        tweetTextLabel.text = tweet.text as? String
        timeStampLabel.text = tweet.timestampString
        
        let profilePath = tweet.profileUrl
        if let profilePath = profilePath {
            profileImageView.setImageWithURL(NSURL(string: profilePath)!)
        }
        favCountLabel.text = "\(tweet.favoritesCount)"
        retweetCountLabel.text = "\(tweet.retweetCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        /*if favorited == false {
            favorited = true
            var count = Int(fav.text!)
            count = count! + 1
            favCountLabel.text = "\(count!)"
            let favoriteImage = UIImage(named: "like_on")
            favoriteButton.setImage(favoriteImage, forState: .Normal)
        } else {
            // do nothing
        }*/
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        /*if retweeted == false {
            retweeted = true
            var count = Int(retweetCountLabel.text!)
            count = count! + 1
            retweetCountLabel.text = "\(count!)"
        } else {
            // do nothing
        }*/
    }
    
    @IBAction func onTapProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("ProfileSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ReplySegue" {
            let replyViewController = segue.destinationViewController as! ReplyViewController
            replyViewController.tweet = tweet
        } else if segue.identifier == "ProfileSegue" {
            let screenname = tweet.screenname as! String
                
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.screenname = screenname
            profileViewController.tweet = tweet
        }
    }

}
