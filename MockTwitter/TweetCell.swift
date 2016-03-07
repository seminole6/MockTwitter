//
//  TweetCell.swift
//  MockTwitter
//
//  Created by Devon Maguire on 2/28/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.screenname as? String
            tweetLabel.text = tweet.text as? String
            timeStamp.text = tweet.timestampString
            
            let profilePath = tweet.profileUrl
            if let profilePath = profilePath {
                profileImageView.setImageWithURL(NSURL(string: profilePath)!)
            }
            profileImageView.userInteractionEnabled = true
            numFavoritesLabel.text = "\(tweet.favoritesCount)"
            numRetweetsLabel.text = "\(tweet.retweetCount)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if tweet != nil {
            if (tweet.favorited == false) {
                let favoriteImage = UIImage(named: "like_off")
                favoriteButton.setImage(favoriteImage, forState: .Normal)
            } else {
                let favoriteImage = UIImage(named: "like_off")
                favoriteButton.setImage(favoriteImage, forState: .Normal)
            }
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func onFavorite(sender: AnyObject) {
        if tweet.favorited == false {
            tweet.favorited = true
            var count = Int(numFavoritesLabel.text!)
            count = count! + 1
            numFavoritesLabel.text = "\(count!)"
            let favoriteImage = UIImage(named: "like_on")
            favoriteButton.setImage(favoriteImage, forState: .Normal)
            
            TwitterClient.sharedInstance.favoriteTweet(String(tweet.tweetId), success: { (success: [Tweet]) -> () in
                
                }, failure: { (error: NSError) -> () in
                    print("Error: \(error.localizedDescription)")
            })
        } else {
            // do nothing
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            var count = Int(numRetweetsLabel.text!)
            count = count! + 1
            numRetweetsLabel.text = "\(count!)"
            
            TwitterClient.sharedInstance.retweetTweet(String(tweet.tweetId), success: { (success: [Tweet]) -> () in
                
                }, failure: { (error: NSError) -> () in
                    print("Error: \(error.localizedDescription)")
            })
        } else {
            // do nothing
        }
    }
    
    
}
