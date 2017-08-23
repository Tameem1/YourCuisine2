//
//  Orders.swift
//  Your Cuisine
//
//  Created by Make school on 8/22/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
struct Orders {
    let username: String
    let Order: String
    let Location:String
    
    
    init(username: String, Order: String, Location: String) {
        self.username = username
        self.Order = Order
        self.Location = Location
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String,
            let Order = dict["Order"] as? String,
            let Location = dict["Location"] as? String

            
            
            else { return nil }
        
        self.username = username
        self.Order = Order
        self.Location = Location
        }
}
