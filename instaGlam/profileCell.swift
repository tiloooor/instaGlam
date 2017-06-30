//
//  profileCell.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/30/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class profileCell: UICollectionViewCell {
    
    @IBOutlet weak var profileCell: PFImageView!
    
    var post: PFObject! {
        didSet {
            self.profileCell.file = post["media"] as? PFFile
            self.profileCell.loadInBackground()
        }
    }
}

