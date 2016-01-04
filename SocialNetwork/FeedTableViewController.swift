//
//  FeedTableViewController.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/7/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import UIKit
import SwiftDate
import Foundation

class FeedTableViewController: UITableViewController {
    var posts = Array<Post>()
    var user : User?
    var image : UIImage?
    var userImages = NSMutableDictionary()
    var userImagesStatus = NSMutableDictionary()
    var selectedPostId : Int?
    
    
    func doFeedRequest() {
        let requestUrl = NSURL(string: "https://cristiangomez.me/api/me/feed?fields[posts]=message,created_at")
        let task = NSURLSession.sharedSession().dataTaskWithURL(requestUrl!) {(data, response, error) in
            if (error == nil) {
                let parsedData = self.parseData(data!)
                let newPosts = PostParser.parsePosts(parsedData!, fields: ["message"])
                for post in newPosts {
                    if (!self.posts.contains(post)) {
                        self.posts.append(post)
                        self.posts.sortInPlace({ $0.postId > $1.postId })
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } else {
                print(error)
                print("an error has ocurred")
            }
        }
        task.resume()
    }
    
    func doUserRequest() {
        let accessToken = Auth.getAccessToken()!
        let requestUrl = NSURL(string: "https://cristiangomez.me/api/me?fields%5Busers%5D=first_name,last_name&fields%5Bpictures%5D=id,url&include=picture&access_token=\(accessToken)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(requestUrl!) {(data, response, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                if (httpResponse.statusCode == 200) {
                    if (error == nil) {
                        let parsedData = self.parseData(data!)
                        self.user = UserParser.parseUser(parsedData!, fields: ["first_name", "last_name"], includes: ["picture"])
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    } else {
                        print(error)
                        print("an error has ocurred")
                    }
                }
                else if (httpResponse.statusCode == 401) {
                    Auth.requestAccessToken(self.doUserRequest);
                }
            }
        }
        task.resume()
    }
    
    
    func parseData(let data : NSData) -> NSDictionary? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
        } catch {
            return nil
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as!PostTableViewCell
        //         Configure the cell...
        let post = self.posts[indexPath.row]
        cell.postSummaryLabel.text = post.text
        cell.comment.tag = post.postId
        //        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width / 2;
        //        cell.userImageView.clipsToBounds = true
        if (user != nil) {
            cell.userNameLabel.text = user!.firstName! + " " + user!.lastName!;
        }
        if (user != nil && self.userImagesStatus[String(self.user?.id)] == nil) {
            self.userImagesStatus.setValue(true, forKey: String(self.user?.id))
            let url = NSURL(string: user!.picture!.url!)
            let request : NSURLRequest = NSURLRequest(URL: url!)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in if error == nil {
                    self.userImages.setValue(UIImage(data: data!), forKey: String(self.user?.id))
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            }
            task.resume()
        }
        if (self.userImages[String(user?.id)] != nil) {
            cell.userImageView.image = self.userImages[String(user?.id)] as? UIImage
        }
        cell.postDateLabel.text =  post.createdAt!.toRelativeString(abbreviated: false, maxUnits:1)
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        doUserRequest()
        doFeedRequest()
        
    }
    
    @IBAction func commentPost(sender: UIButton) {
        self.selectedPostId = sender.tag
        showPost()
    }
    
    func showPost() {
        performSegueWithIdentifier("postDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "postDetail") {
            if let singlePost = segue.destinationViewController as? SinglePostViewController {
                singlePost.postId = self.selectedPostId!
            }
        }
    }
    
}
