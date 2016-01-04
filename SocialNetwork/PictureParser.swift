//
//  PictureParser.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/10/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
struct PictureParser {
    static func parsePicture(data : NSDictionary) -> Picture {
        let picture = Picture(id: Int(data["id"] as! String)!)
        picture.url = data["attributes"]!["url"] as? String
        return picture
    }
}