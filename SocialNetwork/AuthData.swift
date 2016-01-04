//
//  AuthData.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/21/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import Foundation

struct AuthData {
    static let base_url = "https://cristiangomez.me/api/"
    static let client_id = "a2fa5fe1-9837-48f1-ae91-fc2a6cb85404"
    static let client_secret = "abc"
    static let token_url = base_url+"oauth/token"
}

struct Auth {
    static func getAccessToken() -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey("access_token") as? String
    }
    
    static func getRefreshToken() -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey("refresh_token") as? String
    }
    
    static func requestAccessToken(completion: (() -> Void)!) {
        let params = "?grant_type=refresh_token&refresh_token=\(getRefreshToken()!)&client_id=\(AuthData.client_id)&client_secret=\(AuthData.client_secret)"
        let urlStr = AuthData.token_url+params
        print(urlStr)
        let request = NSMutableURLRequest(URL : NSURL(string: urlStr)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            if (error == nil) {
                let parsedData = parseData(data!)!
                let accessToken = parsedData["access_token"] as! String
                let refreshToken = parsedData["refresh_token"] as! String
                NSUserDefaults.standardUserDefaults().setValue(accessToken,
                    forKey: "access_token")
                NSUserDefaults.standardUserDefaults().setValue(refreshToken, forKey: "refresh_token")
                if ((completion) != nil) {
                    completion()
                }
            }
            else {
                print(error)
                print("an error has ocurred")
            }
        }
        task.resume()
    }
    
    static func parseData(let data : NSData) -> NSDictionary? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
        } catch {
            return nil
        }
    }
}