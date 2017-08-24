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
    
    
    @IBOutlet weak var UserNumberInRestaurnt: UILabel!
    @IBOutlet weak var UserAddressInRestaurnt: UILabel!
    @IBOutlet weak var OrderInRestaurant: UILabel!
    @IBOutlet weak var orderInKitchen: UIButton!
    @IBOutlet weak var OrderInWay: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        OrderInWay.isEnabled = false
        OrderInWay.layer.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.0).cgColor

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OrderInKitchenTapped(_ sender: Any) {
        print("this Button Tapped")

        orderInKitchen.isEnabled = false
        orderInKitchen.layer.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.0).cgColor
        OrderInWay.layer.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0).cgColor
        OrderInWay.titleLabel?.textColor = UIColor.white
        OrderInWay.isEnabled = true
        
        
        
    }
    
    @IBAction func OrderInWayTapped(_ sender: Any) {
        print("button tapped")
    }
    
}
