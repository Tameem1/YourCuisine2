//
//  RestaurantService.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct RestaurantService {
    //dfgn
    static func createRestaurant(_ firUser: FIRUser, RName: String, RNumber: String, completion: @escaping (Restaurant?) -> Void) {
        let userAttrs = ["RName": RName,"RNumber": RNumber]
        
        
        let ref = Database.database().reference().child("restaurants").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
        }
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let user = Restaurant(snapshot: snapshot)
            completion(user)
        })
    }
    
    static func show(forUID uid: String, completion: @escaping (Restaurant?) -> Void) {
        let ref = Database.database().reference().child("restaurants").child(uid)
        ref.observeSingleEvent(of: .value, with:{ (snapshot) in
            guard let user = Restaurant (snapshot:snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
}
