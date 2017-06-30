//
//  CaptureViewController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse
import Fusuma


class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, FusumaDelegate {

    // MARK: Properties
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var currentUserLabel: UILabel!
    
    
    @IBOutlet weak var imageSelectionView: UIView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var postButton: UIButton!
    
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        captionTextField.delegate = self
        
    }
    
    // MARK: Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by UIImagePickerController
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do sum with the pictures
        selectedImage.contentMode = .scaleAspectFit
        selectedImage.image = editedImage
        imageSelectionView.backgroundColor = .clear
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        vc.sourceType = .photoLibrary
//        captionTextField.isHidden = false
//        
//        present(vc, animated: true, completion: nil)
        
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.hasVideo = true // If you want to let the users allow to use video.
        self.present(fusuma, animated: true, completion: nil)
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        
        switch source {
            
        case .camera:
            
            print("Image captured from Camera")
            
        case .library:
            
            print("Image selected from Camera Roll")
            
        default:
            
            print("Image selected")
        }
        
        selectedImage.image = image
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
        print("Number of selection images: \(images.count)")
        
        var count: Double = 0
        
        for image in images {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (3.0 * count)) {
                
                self.selectedImage.image = image
                print("w: \(image.size.width) - h: \(image.size.height)")
            }
            count += 1
        }
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
        print("video completed and output to file: \(fileURL)")
        //self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
    }
    
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested",
                                      message: "Saving image needs to access your photo album",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                
                UIApplication.shared.openURL(url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressPostButton(_ sender: Any) {
        Post.postUserImage(image: selectedImage.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            if success {
                print("successfully posted!")
            } else if let error = error {
                print(String(describing: error.localizedDescription))
            }
        }
        self.dismiss(animated: true, completion: nil)
        }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerEditedImage] as? UIImage
//        if image != nil {
//            selectedImage.image = image
//            captionTextField.isHidden = false
//            dismiss(animated: true, completion: nil)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    
    
    
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


