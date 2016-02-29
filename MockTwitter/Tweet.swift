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
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        screenname = dictionary["user"]!["screen_name"] as? String
        profileUrl = dictionary["user"]!["profile_image_url"] as? String
        
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
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
        
    }

}
