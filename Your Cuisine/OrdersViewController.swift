//
//  OrdersViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
class OrdersViewController: UIViewController{
    
    var myOrder: Orders?
    
    @IBOutlet weak var UserNumberInRestaurnt: UILabel!
    @IBOutlet weak var UserAddressInRestaurnt: UILabel!
    @IBOutlet weak var OrderInRestaurant: UILabel!
    @IBOutlet weak var orderInKitchen: UIButton!
    @IBOutlet weak var OrderInWay: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        OrderInWay.isEnabled = false
        OrderInWay.layer.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.0).cgColor
        
        OrderService.checkIfIsOnWay(order: myOrder!, restId: "Hardee's") { (c) -> () in
            
            if (c)
            {
                self.OrderInWay.isEnabled = false
                self.OrderInWay.setTitle("Order is already on the way", for: .normal)
                self.OrderInWay.backgroundColor = UIColor(red:0.96, green:0.49, blue:0.00, alpha:1.0)

            }
            
        }
        
        OrderService.checkIfIsInKitchen(order: myOrder!, restId: "Hardee's") { (c) -> () in
            
            if (c)
            {
                self.orderInKitchen.isEnabled = false
                self.orderInKitchen.setTitle("Order is Already in Kitchen", for: .normal)
                self.orderInKitchen.backgroundColor = UIColor(red:0.96, green:0.49, blue:0.00, alpha:1.0)

            }
            
        }
        
        
        

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderInRestaurant.text = myOrder?.Order
        self.UserAddressInRestaurnt.text = myOrder?.Location
        self.UserNumberInRestaurnt.text = myOrder?.phoneNumber
    }
    
    @IBAction func OrderInKitchenTapped(_ sender: Any) {
        print("this Button Tapped")

        orderInKitchen.isEnabled = false
        orderInKitchen.layer.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.0).cgColor
        OrderInWay.layer.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0).cgColor
        OrderInWay.titleLabel?.textColor = UIColor.white
        OrderInWay.isEnabled = true
        OrderService.orderInKitchen(order: myOrder!, restId: "Hardee's")

//       OrderService.isAccepted(order: myOrder!, restId: "Hardee's") // TODO: change this to depend on actual restaurant
        
    }

    @IBAction func OrderInWayTapped(_ sender: Any) {
        OrderService.orderOnWay(order: myOrder!, restId: "Hardee's")
       
        
        print("button tapped")
    }
    
}
