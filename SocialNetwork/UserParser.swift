//
//  UserParser.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/10/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
enum UserParser {
    static func parseUser(data : NSDictionary, fields: Array<String>, includes : Array<String>) -> User {
        let userId = Int(data["data"]!["id"] as! String)
        let userAttributes = data["data"]!["attributes"] as! NSDictionary
        let user = User(id: userId!)
        user.firstName = userAttributes["first_name"] as? String
        user.lastName = userAttributes["last_name"] as? String
        if includes.contains("picture") {
            user.picture = PictureParser.parsePicture((data["included"] as! NSArray)[0] as! NSDictionary)
        }
        return user
    }
}