//
//  SinglePostViewController.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 1/4/16.
//  Copyright © 2016 Cristian J Gomez. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate
import AlamofireImage

class SinglePostViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var post : Post?
    var postId : Int?
    var user : User?
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        SnetworkApiManager.sharedInstance.getPost(postId!, callback: { post in
            self.post = post
            self.displayPost()
        })
    }
    
    func displayPost() {
        self.summaryLabel.text = self.post?.text
        self.dateLabel.text = self.post?.createdAt?.toRelativeString(abbreviated: true, maxUnits: 2)
        self.usernameLabel.text = self.post?.user?.firstName
        print(self.post?.user?.picture?.url)
        self.userImage.af_setImageWithURL(NSURL(string: (self.post?.user?.picture?.url!)!)!)
    }
    
}