//
//  TweetCell.swift
//  MockTwitter
//
//  Created by Devon Maguire on 2/28/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var retweeted = false
    var favorited = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /*let retweetImage = UIImage(named: "retweet")
        retweetButton.setImage(retweetImage, forState: .Normal)
        
        let favoriteImage = UIImage(named: "like_off")
        favoriteButton.setImage(favoriteImage, forState: .Normal)*/
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFavorite(sender: AnyObject) {
        if favorited == false {
            favorited = true
            var count = Int(numFavoritesLabel.text!)
            count = count! + 1
            numFavoritesLabel.text = "\(count!)"
            /*let favoriteImage = UIImage(named: "like_on")
            favoriteButton.setImage(favoriteImage, forState: .Normal)*/
        } else {
            // do nothing
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if retweeted == false {
            retweeted = true
            var count = Int(numRetweetsLabel.text!)
            count = count! + 1
            numRetweetsLabel.text = "\(count!)"
        } else {
            // do nothing
        }
    }
}
