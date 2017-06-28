//
//  loginViewController.swift
//  instaGlam
//
//  Created by Tyler Holloway on 6/28/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse 

class loginViewController: UIViewController {
    // MARK: Properties 
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true

    }
    
    @IBAction func pressRegisterButton(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Yay, registered new user!")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    
    @IBAction func pressLoginButton(_ sender: Any) {
        //someCode here
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
