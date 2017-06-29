//
//  Post.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {

    let creationTime: TimeInterval?
    let media: PFFile?
    let authorId: String?
    let caption: String?
    let likeCount: Int?
    let commentsCount: Int?
    
    init(pfObject: PFObject) {
        creationTime = pfObject["creationTime"] as? TimeInterval
        media = pfObject["media"] as? PFFile
        authorId = pfObject["authorId"] as? String
        caption = pfObject["caption"] as? String
        likeCount = pfObject["likeCount"] as? Int
        commentsCount = pfObject["commentsCount"] as? Int
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
//        // DON'T UNDERSTAND 
//        
//        let post = PFObject(className: "Post")
//        
//        post["creationTime"] = Date.timeIntervalSinceReferenceDate
//        post["media"] = getPFFileFromImage(image)
//        post["authorId"] = PFUser.current()?.objectId
//        post["caption"] = caption
//        post["likeCount"] = 0
//        post["commentCount"] = 0
        
        // Create Parse object PFObject
        let post = PFObject (className: "Post")
        
        // Add relevant fields to the object
        post["creationTime"] = Date.timeIntervalSinceReferenceDate
        post["media"] = getPFFileFromImage(image: image)
        post["authorId"] = PFUser.current()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)

    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        //check if image is not nil
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)!
            }
        }
        return nil
    }
}


