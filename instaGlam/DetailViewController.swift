//
//  DetailViewController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/29/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    
    //MARK: Properties 
    
    
    
    @IBOutlet weak var postDetailImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    
    
    var post: PFObject!
    
    override func viewDidAppear(_ animated: Bool) {
        self.postDetailImage.file = post["media"] as? PFFile
        self.postDetailImage.loadInBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.captionLabel.text = post["caption"] as? String
        
        if let creationTime = post["creationTime"] {
            let postDateFormatter: DateFormatter = {
                let f = DateFormatter()
                f.dateFormat = "MMM d, yyyy"
                return f
            }()
            self.timeStampLabel.text = postDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: creationTime as! TimeInterval))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
