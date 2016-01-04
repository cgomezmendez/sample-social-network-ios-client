//
//  PostTableViewCell.swift
//  SocialNetwork
//
//  Created by Cristian J Gomez on 12/7/15.
//  Copyright © 2015 Cristian J Gomez. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    //Mark: Properties
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postSummaryLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var comment: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
