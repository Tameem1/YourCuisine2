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
    let phoneNumber:String
    let orderAccepted:Bool
    let orderInKitchen:Bool
    let orderInWay:Bool
    
    
    init(username: String, Order: String, Location: String, phoneNumber: String,orderInKitchen:Bool,orderAccepted:Bool,orderInWay:Bool) {
        self.username = username
        self.Order = Order
        self.Location = Location
        self.phoneNumber = phoneNumber
        self.orderAccepted = orderAccepted
        self.orderInKitchen = orderInKitchen
        self.orderInWay = orderInWay
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String,
            let Order = dict["Order"] as? String,
            let phoneNumber = dict["phoneNumber"] as? String,
            let Location = dict["Location"] as? String,
            let orderAccepted = dict["orderAccepted"] as? Bool,
            let orderInKitchen = dict["orderInKitchen"] as? Bool,
            let orderInWay = dict["orderInWay"] as? Bool

        

        
            
            else { return nil }
        
        self.username = username
        self.Order = Order
        self.Location = Location
        self.phoneNumber = phoneNumber
        self.orderAccepted = orderAccepted
        self.orderInKitchen = orderInKitchen
        self.orderInWay = orderInWay
        }
}
