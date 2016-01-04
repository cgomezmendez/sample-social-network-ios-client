//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/6/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var loggedIn = false
    
    // MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Mark: Actions
    @IBAction func loginClick(sender: AnyObject) {
        doLoginRequest()
    }
    
    func doLoginRequest() {
        let username = self.usernameTextField.text!
        let password = passwordTextField.text!
        let params = "?grant_type=password&username=\(username)&password=\(password)&client_id=\(AuthData.client_id)&client_secret=\(AuthData.client_secret)"
        let urlStr = AuthData.token_url+params
        let request = NSMutableURLRequest(URL : NSURL(string: urlStr)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            if (error == nil) {
                let parsedData = self.parseData(data!)!
                let accessToken = parsedData["access_token"] as! String
                let refreshToken = parsedData["refresh_token"] as! String
                NSUserDefaults.standardUserDefaults().setValue(accessToken,
                    forKey: "access_token")
                NSUserDefaults.standardUserDefaults().setValue(refreshToken, forKey: "refresh_token")
                NSUserDefaults.standardUserDefaults().synchronize()
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("nextView", sender: self)
                }
            } else {
                print(error)
                print("an error has ocurred")
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
    
    
    override func viewDidAppear(animated: Bool) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey("access_token")
        let refreshToken = NSUserDefaults.standardUserDefaults().valueForKey("refresh_token")
        if accessToken != nil && refreshToken != nil {
            loggedIn = true
            self.performSegueWithIdentifier("nextView", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    
}

