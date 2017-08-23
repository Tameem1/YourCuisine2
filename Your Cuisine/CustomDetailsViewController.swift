//
//  CustomDetailsViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/16/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
class CustomDetailsViewController: UIViewController {
    
    @IBOutlet weak var UserType: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
        let username = usernameTextField.text,
        let phoneNumber = phoneNumberTextField.text,

            !username.isEmpty,
            !phoneNumber.isEmpty
            
            else {return}
    
        
        UserService.create(firUser, username: username, phoneNumber: phoneNumber, isRestaurant: false) { (user) in
            guard let user = user else {
                return
            }
            User.setCurrent(user, writeToUserDefaults: true )
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        }
    }
