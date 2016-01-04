//
//  Utils.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 1/4/16.
//  Copyright © 2016 Cristian J Gomez. All rights reserved.
//

import Foundation

func parseData(let data : NSData) -> NSDictionary? {
    do {
        return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
    } catch {
        return nil
    }
}