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
    var username: [PFObject]?
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        updatePosts()
        
//        // Set up Refresh Control
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
//        tableView.insertSubview(refreshControl, at: 0)
        
    }
    
    func updatePosts() {
        // Construct query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "creationTime")
        query.limit = 20
        query.includeKey("authorId")
        
        
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
