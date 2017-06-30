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
    
    
    @IBOutlet weak var feedUserNameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    
    
    
    var post: PFObject! {
        didSet {
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            let author = post["authorId"] as? PFUser
            
            
            if let creationTime = post["creationTime"] {
                let postDateFormatter: DateFormatter = {
                    let f = DateFormatter()
                    f.dateFormat = "MMM d, yyyy"
                    return f
                }()
                self.timeStamp.text = postDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: creationTime as! TimeInterval))

            }
            
            if let user = post["authorId"] as? PFUser {
                self.feedUserNameLabel.text = user.username
            } else {
                self.feedUserNameLabel.text = " "
            }
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
