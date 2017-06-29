//
//  postCellTableViewCell.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class postCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            let author = post["author"] as? PFUser
            self.userNameLabel.text = author?["username"] as? String
            self.captionLabel.text = post["caption"] as? String
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
