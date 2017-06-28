//
//  CaptureViewController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

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
        
        selectedImage.image = nil
        captionTextField.text = nil
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
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func pressPostButton(_ sender: Any) {
        
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