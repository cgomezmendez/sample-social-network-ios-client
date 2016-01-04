//
//  PostPublishController.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 1/3/16.
//  Copyright © 2016 Cristian J Gomez. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class PostPublishController: UIViewController {
    @IBOutlet weak var postText: KMPlaceholderTextView!
    
    @IBAction func cancelPublish(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func publishPost(sender: UIButton) {
        SnetworkApiManager.sharedInstance.updateStatus(self.postText.text, callback: {
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        (postText as KMPlaceholderTextView).placeholder = "Write something..."
    }
    
    
    
    
}
