//
//  SnetworkApiManager.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 1/4/16.
//  Copyright © 2016 Cristian J Gomez. All rights reserved.
//

import Foundation
import Alamofire

class SnetworkApiManager {
    static let sharedInstance = SnetworkApiManager()
    
    let baseURL = "https://cristiangomez.me/api/"
    
    func updateStatus(message : String, callback: () -> Void) {
        let headers = [
            "Authorization": "Bearer \(Auth.getAccessToken()!)"
        ]
        Alamofire.request(.POST, baseURL+"me/feed", parameters: ["message": message],
            headers: headers)
            .responseJSON{response in
                if let data = response.result.value as? NSDictionary {
                    callback()
                }
                
        }
    }
    
    func getPost(postId : Int, callback: (post : Post?) -> Void) {
        Alamofire.request(.GET, baseURL+"posts/\(postId)", parameters: ["fields[posts]": "message,created_at",
            "fields[users]":"first_name,last_name", "fields[pictures]":"url", "include":"user,picture"
            ])
            .responseJSON(completionHandler: { response in
                if let data = response.result.value as? NSDictionary {
                    let post = PostParser.parsePost(data, fields: ["message", "created_at"], includes: ["user", "picture"])
                    callback(post: post)
                }
            })
    }
    
    func getUser(userId: Int, callback: (user: User?) -> Void) {
        Alamofire.request(.GET, baseURL+"/\(userId)", parameters: [
            "fields[users]":"firstname,lastname", "fields[pictures]":"id,url","include":"picture"
            ])
            .responseJSON(completionHandler: { response in
                if let data = response.result.value as? NSDictionary {
                    let user = UserParser.parseUser(data, fields: ["first_name", "last_name"],
                        includes: ["picture"])
                    callback(user: user)
                }
            })
    }
}


class Response {
    var data : NSDictionary
    
    init(data : NSDictionary) {
        self.data = data
    }
}

class ResponseData {
    var attributes : NSMutableDictionary?
    var id : Int?
    var type : String?
}