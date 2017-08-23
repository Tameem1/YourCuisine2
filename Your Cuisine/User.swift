//
//  User.swift
//  Your Cuisine
//
//  Created by Make school on 8/15/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: NSObject {
    
    // MARK: - Properties
    let isRestaurant : Bool
    let uid: String
    let username: String
    let phoneNumber: String
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as?String,
            let phoneNumber = aDecoder.decodeObject(forKey: Constants.UserDefaults.phoneNumber) as? String,
            let isRestaurant = aDecoder.decodeBool(forKey: Constants.UserDefaults.isRestaurant) as? Bool

        
            else { return nil }
        self.uid = uid
        self.username = username
        self.phoneNumber = phoneNumber
        self.isRestaurant = isRestaurant

        super.init()
    }
    
    
    init(uid: String, username: String, phoneNumber: String, RName: String, RNumber: String, isRestaurant: Bool) {
        self.uid = uid
        self.username = username
        self.phoneNumber = phoneNumber
        self.isRestaurant = isRestaurant
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String,
            let phoneNumber = dict["phoneNumber"] as? String,
            let isRestaurant = dict["isRestaurant"] as? Bool
        

            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        self.phoneNumber = phoneNumber
        self.isRestaurant = isRestaurant

     super.init()
    }
    
    // MARK: - Singleton
    
    // 1
    private static var _current: User?
    
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // 4
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }
}



extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
        aCoder.encode(phoneNumber, forKey: Constants.UserDefaults.phoneNumber)
        aCoder.encode(isRestaurant, forKey: Constants.UserDefaults.isRestaurant)

        



    }
}
