//
//  UserService.swift
//  Your Cuisine
//
//  Created by Make school on 8/15/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    static func create(_ firUser: FIRUser, username: String, phoneNumber: String, isRestaurant: Bool, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username,
                         "phoneNumber": phoneNumber,
                         "isRestaurant": isRestaurant] as [String : Any]
        
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with:{ (snapshot) in
            guard let user = User (snapshot:snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
}
