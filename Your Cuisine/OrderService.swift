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
    static func create(RestaurantId: String, username: String, phoneNumber: String, Order: String, Location: String, orderAccepted:Bool, orderInKitchen:Bool, orderInWay:Bool, completion: @escaping (Orders?) -> Void) {
        let userAttrs = ["username": username,
                         "Order": Order,
                         "phoneNumber": phoneNumber,
                         "orderAccepted": orderAccepted,
                         "orderInKitchen": orderInKitchen,
                         "orderInWay": orderInWay,
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
    
    static func isAccepted(order: Orders, restId: String){
        let OrderAttrs = ["orderAccepted": true]
         let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username)
        
        
        ref.updateChildValues(OrderAttrs)
        
//        { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
////                return completion(nil)
//            }
//            
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let Order = Orders(snapshot: snapshot)
//                completion(Order)
//            })
       // }
        
    }
    static func orderInKitchen(order: Orders, restId: String){
        let OrderAttrs = ["orderInKitchen": true]
        let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username)
        
        
        ref.updateChildValues(OrderAttrs)
    }
    
    static func orderOnWay(order: Orders, restId: String){
        let OrderAttrs = ["orderInWay": true]
        let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username)
        
        
        ref.updateChildValues(OrderAttrs)
    }
    
    
    static func checkIfIsAccepted(order: Orders, restId: String ,completionHandler: @escaping (Bool) -> Void ) {
    
     let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username).child("orderAccepted")
        ref.observeSingleEvent(of: .value, with: { snapshot in
completionHandler(snapshot.value as! Bool)

        })

    }
    
    static func checkIfIsOnWay(order: Orders, restId: String ,completionHandler: @escaping (Bool) -> Void ) {
        
        let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username).child("orderInWay")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            completionHandler(snapshot.value as! Bool)
            
        })
        
    }
    
    
    
    
    static func checkIfIsInKitchen(order: Orders, restId: String ,completionHandler: @escaping (Bool) -> Void ) {
        
        let ref = Database.database().reference().child("restaurants").child(restId).child("Orders").child(order.username).child("orderInKitchen")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            completionHandler(snapshot.value as! Bool)
            
        })
        
    }
    
}
    
    
    

