//
//  OrderStausViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/25/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
class OrderStausViewController : UIViewController {
    
    
    @IBOutlet weak var orderAccepted: UILabel!
    @IBOutlet weak var orderInKitchenLabel: UILabel!
    @IBOutlet weak var OrderInWayLabel: UILabel!
    
    @IBOutlet weak var orderAcceptedButton: UIButton!
   
    @IBOutlet weak var orderInKitchenButton: UIButton!
    
    @IBOutlet weak var orderOnWayButton: UIButton!
    
    var order: Orders?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OrderService.checkIfIsOnWay(order: order!, restId: "Hardee's") { (c) -> () in
            self.orderAccepted.layer.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.0).cgColor
        }
        
    }
    
 
    
}

