//
//  mainTabFeedController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class mainTabFeedController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    var post: [PFObject] = []
    
    
    
    @IBOutlet weak var feedUserNameLabel: UILabel!
    @IBOutlet weak var feedTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        updatePosts()
//        
//        // Make profile pic circular
//        feedPic.layer.borderWidth = 1
//        feedPic.layer.masksToBounds = false
//        feedPic.layer.borderColor = UIColor.lightGray.cgColor
//        feedPic.layer.cornerRadius = feedTableView.frame.height/2
//        feedPic.clipsToBounds = true
        

        
        // Set up Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        feedTableView.insertSubview(refreshControl, at: 0)
        
    }
    
    func updatePosts() {
        // Construct query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "creationTime")
        query.limit = 20
        query.includeKey("authorId")
        //query.includeKey("caption")
        
        
        query.findObjectsInBackground { (posts: [PFObject]?,
            error: Error?) in
            if let posts = posts {
                self.post = posts
                self.feedTableView.reloadData()
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
    let posts = self.post[indexPath.row]
    cell.post = posts
    return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        updatePosts()
        refreshControl.endRefreshing()
    }

}
