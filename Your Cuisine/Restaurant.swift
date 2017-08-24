//
//  Restaurant.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Restaurant: NSObject {
    
    // MARK: - Properties
    
    let uid: String
    let RName: String
    let RNumber: String
    let OpenCloseTime: String
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let RName = aDecoder.decodeObject(forKey: Constants.UserDefaults.RName) as? String,
            let RNumber = aDecoder.decodeObject(forKey: Constants.UserDefaults.RNumber) as? String,
            let OpenCloseTime = aDecoder.decodeObject(forKey: Constants.UserDefaults.OpenCloseTime) as? String

            
            
            else { return nil }
        
        self.uid = uid
        self.RName = RName
        self.RNumber = RNumber
        self.OpenCloseTime = OpenCloseTime
        super.init()
    }
    
    
    init(uid: String, RName: String, RNumber: String, OpenCloseTime: String) {
        self.uid = uid
        self.RName = RName
        self.RNumber = RNumber
        self.OpenCloseTime = OpenCloseTime
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let RName = dict["RName"] as? String,
            let RNumber = dict["RNumber"] as? String,
            let OpenCloseTime = dict["OpenCloseTime"] as? String
            
            
            else { return nil }
        
        self.uid = snapshot.key
        self.RName = RName
        self.RNumber = RNumber
        self.OpenCloseTime = OpenCloseTime
        
        super.init()
    }
    
    // MARK: - Singleton
    
    // 1
    private static var _current: Restaurant?
    
    // 2
    static var current: Restaurant {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    class func setCurrent(_ user: Restaurant, writeToUserDefaults: Bool = false) {
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



extension Restaurant: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(RNumber, forKey: Constants.UserDefaults.RNumber)
        aCoder.encode(RName, forKey: Constants.UserDefaults.RName)
        aCoder.encode(OpenCloseTime, forKey: Constants.UserDefaults.OpenCloseTime)

        
        
        
        
    }
}
