//
//  Tweet.swift
//  MockTwitter
//
//  Created by Devon Maguire on 2/28/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit
import AFNetworking

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var screenname: NSString?
    var profileUrl: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var timestampString: String?
    var backUrl: String?
    var followCount: Int = 0
    var followerCount: Int = 0
    var tweetCount: Int = 0
    var tweetId: Int = 0
    var name: String?
    var retweeted: Bool
    var favorited: Bool
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        screenname = dictionary["user"]!["screen_name"] as? String
        name = dictionary["user"]!["name"] as? String
        profileUrl = dictionary["user"]!["profile_image_url"] as? String
        backUrl = dictionary["user"]!["profile_background_image_url"] as? String
        
        timestampString = dictionary["created_at"] as? String
        let temp = timestampString?.componentsSeparatedByString(" ")
        let temp2 = temp![3].componentsSeparatedByString(":")
        timestampString = "\(temp![0]) \(temp2[0]):\(temp2[1])"
        
        /*if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }*/
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        followCount = (dictionary["user"]!["friends_count"] as? Int) ?? 0
        followerCount = (dictionary["user"]!["followers_count"] as? Int) ?? 0
        tweetCount = (dictionary["user"]!["statuses_count"] as? Int) ?? 0
        tweetId = (dictionary["id"] as? Int) ?? 0
        
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            //print(tweet.screenname)
        }
        
        return tweets
        
    }

}
