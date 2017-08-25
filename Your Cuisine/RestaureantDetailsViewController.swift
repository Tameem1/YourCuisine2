//
//  RestaureantDetailsViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
class RestaureantDetailsViewController: UIViewController {
    
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var nextButton1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton1.layer.cornerRadius = 10
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let firUser = Auth.auth().currentUser,
            let RName = textField1.text,
            let RNumber = textField2.text,
            let OpenCloseTime = textField3.text,
            
            
            !RName.isEmpty,
            !RNumber.isEmpty,
            !OpenCloseTime.isEmpty
        
            
            else {return}
        
        
        UserService.create(firUser, username: RName, phoneNumber: RNumber, isRestaurant: true) { (user) in
            guard let user = user else {
                return
            }
            User.setCurrent(user, writeToUserDefaults: true )
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        
        RestaurantService.createRestaurant(firUser, RName: RName, RNumber: RNumber, OpenCloseTime: OpenCloseTime) { (restaurant) in
            if let restaurant = restaurant {
                Restaurant.setCurrent(restaurant, writeToUserDefaults: true)
                let initialViewController = UIStoryboard.initialViewController(for: .restaurant)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
                return
            } else {
                print("empty")
            }
            
            
        }
    }

        
    }
