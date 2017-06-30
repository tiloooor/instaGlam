//
//  ProfileViewController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/29/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: Properties 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var profileImageView: PFImageView!
    
    let picker = UIImagePickerController()
    
    var posts : [PFObject]!
    var user : PFUser!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = PFUser.current()
        
        // For picture
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true

        
        collectionView.dataSource = self
        collectionView.delegate = self
        updatePosts()
        
        //allows us to do something of the things that we've been doing in interface builder
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        //last cell won't have any spacing
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        
        // Do any additional setup after loading the view.
      
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
                self.posts = posts
                self.collectionView.reloadData()
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    
//    func updatePosts() {
//        // Construct query
//        let query = PFQuery(className: "Post")
//        query.order(byDescending: "createdAt")
//        query.includeKey("author")
//        query.whereKey("author", equalTo: user)
//        
//        // Fetch data asynchronously
//        query.findObjectsInBackground { (posts: [PFObject]?,
//            error: Error?) in
//            if let posts = posts {
//                self.posts = posts
//                self.collectionView.reloadData()
//            } else {
//                print(String(describing: error?.localizedDescription))
//            }
//        }
//    }
//    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! profileCell
        let post = self.posts[indexPath.row]
            cell.post = post
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.size.width
        let numberOfCellsPerRow = 3
        let dimension = CGFloat(Int(totalWidth) / numberOfCellsPerRow) - 4
        return CGSize.init(width: dimension, height: dimension)
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
