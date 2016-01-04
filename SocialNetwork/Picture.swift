//
//  Picture.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/10/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
class Picture {
    let id : Int
    var url : String?
    
    init(id : Int) {
        self.id = id
    }
    
    init(id : Int, url : String) {
        self.id = id
        self.url = url
    }
}