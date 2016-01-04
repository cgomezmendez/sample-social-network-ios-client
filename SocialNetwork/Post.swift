//
//  Post.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/9/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
class Post : Hashable, Equatable {
    let postId : Int
    var text : String?
    var createdAt : NSDate?
    var user : User?
    var hashValue : Int {
        return self.postId
    }
    
    init(postId : Int) {
        self.postId = postId
    }
    
    init(postId : Int, text : String, createdAt : NSDate) {
        self.postId = postId
        self.text = text
        self.createdAt = createdAt
    }
}

func ==(lhs: Post, rhs : Post) -> Bool {
    return lhs.postId == rhs.postId
}