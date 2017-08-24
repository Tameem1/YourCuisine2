//
//  OrderService.swift
//  Your Cuisine
//
//  Created by Make school on 8/22/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct OrderService {
    static func create(RestaurantId: String, username: String,  Order: String, Location: String, completion: @escaping (Orders?) -> Void) {
        let userAttrs = ["username": username,
                         "Order": Order,
                         "Location": Location] as [String : Any]
        
        
        let ref = Database.database().reference().child("restaurants").child(RestaurantId).child("Orders").child(username)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let Order = Orders(snapshot: snapshot)
                completion(Order)
            })
        }
}
}
