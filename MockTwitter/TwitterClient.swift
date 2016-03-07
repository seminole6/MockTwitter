//
//  TwitterClient.swift
//  MockTwitter
//
//  Created by Devon Maguire on 2/28/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "s10dKMVIwXDMhLz7t23b0HsHN", consumerSecret: "U77BwuIAJOcZIEuu3VuUFqkjJZ1j6gTCDxLTk87dTqEzIWXTE9")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "MockTwitter://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (AccessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                
                self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            /*
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline)")
            */
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func userTimeLine(screen_name: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/user_timeline.json?screen_name=\(screen_name)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, repsonse: AnyObject?) -> Void in
            
            let dictionaries = repsonse as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func replyToTweet(reply: String, userId: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {

        let modreply = reply.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! as String
        
        POST("1.1/statuses/update.json?status=\(modreply)&in_reply_to_status_id=\(Int(userId)).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, repsonse: AnyObject?) -> Void in
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func composeTweet(reply: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {

        let modreply = reply.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! as String
        
        POST("1.1/statuses/update.json?status=\(modreply)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, repsonse: AnyObject?) -> Void in
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func favoriteTweet(userId: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        POST("1.1/favorites/create.json?id=\(userId)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, repsonse: AnyObject?) -> Void in
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func retweetTweet(userId: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        POST("1.1/statuses/retweet/\(userId).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, repsonse: AnyObject?) -> Void in
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }

}
