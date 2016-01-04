//
//  User.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/10/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation
class User {
    let id : Int
    var firstName : String?
    var lastName : String?
    var picture : Picture?
    
    init(id : Int) {
        self.id = id
    }
    
    init(id :Int, firstName : String, lastName : String, picture : Picture) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
    }
}