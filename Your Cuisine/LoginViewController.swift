//
//  LoginViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/14/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase


typealias FIRUser = FirebaseAuth.User



class LoginViewController : UIViewController {
    var restaurantButtonSelected: Bool = false
    var customerButtonSelected: Bool = false
    
    @IBOutlet weak var restaurantButton: UIButton!
    
    @IBOutlet weak var CustomerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantButton.layer.cornerRadius = 22
        restaurantButton.layer.borderWidth = 3
        restaurantButton.layer.borderColor = UIColor(red:0.94, green:0.31, blue:0.34, alpha:1.0).cgColor
        CustomerButton.layer.cornerRadius = 22
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func CustomerButtonTapped(_ sender: Any) {
        self.customerButtonSelected = true
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    
    
    @IBAction func RestaurantButtonTapped(_ sender: Any) {
        self.restaurantButtonSelected = true
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}


extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
            //assertionFailure("Error signing in \(error.localizedDescription)")
            return
        }
        // 1
        guard let user = user
        else {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
            return
        }

        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        // 3
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    User.setCurrent(user, writeToUserDefaults: true)
                    if self.customerButtonSelected{
                        self.performSegue(withIdentifier: "toMainStoryboard", sender: self)
                    }
                    if self.restaurantButtonSelected{
                        self.performSegue(withIdentifier: "toRestaurantStoryboard", sender: self)
                    }
                    
                } else {
                    if self.restaurantButtonSelected {
                        self.performSegue(withIdentifier: Constants.Segue.toRestaurantUsername, sender: self)
                    } else if self.customerButtonSelected {
                        self.performSegue(withIdentifier: Constants.Segue.toCustomerUsername, sender: self)
                    }
                }
            }
        })
}
}
