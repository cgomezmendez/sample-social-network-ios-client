//
//  PostParser.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/9/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
import SwiftDate

struct PostParser {
    static func parsePosts(let data: NSDictionary, let fields : Array<String>) -> Array<Post> {
        var posts = Array<Post>()
        for postDict in data["data"] as! Array<NSDictionary> {
            let attributes = postDict["attributes"] as! NSDictionary
            let post = Post(postId: Int(postDict["id"] as! String)!)
            post.text = attributes["message"] as? String
            let createdAt = attributes["created_at"] as? String
            post.createdAt =  createdAt!.toDate(DateFormat.ISO8601)
            posts.append(post)
        }
        return posts
    }
    
    static func parsePost(let data: NSDictionary, let fields : Array<String>, includes: Array<String>) -> Post {
        let postDict = data["data"] as! NSDictionary
        let attributes = postDict["attributes"] as! NSDictionary
        let post = Post(postId: postDict["id"] as! Int)
        post.text = attributes["message"] as? String
        let createdAt = attributes["created_at"] as? String
        post.createdAt =  createdAt!.toDate(DateFormat.ISO8601)
        var user : User?
        var picture : Picture?
        if let included = data["included"] as? NSArray {
            for include in included {
                let includeData = include["data"]!
                let attributes = includeData!["attributes"] as! NSDictionary
                if (includeData!["type"] as! String == "users") {
                    user = User(id: includeData!["id"] as! Int)
                    user?.firstName = attributes["first_name"] as? String
                    user?.lastName = attributes["last_name"] as? String
                }
                else if (includeData!["type"] as! String == "pictures") {
                    picture = Picture(id: includeData!["id"] as! Int, url: attributes["url"] as! String)
                }
            }
            user?.picture = picture
            post.user = user
        }
        return post
    }
}