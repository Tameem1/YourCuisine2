//
//  ListCellViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class ListCellViewController: UITableViewCell {
    var order: Orders!
    

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var AcceptButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func AcceptButtonTapped(_ sender: Any) {
        AcceptButton.layer.backgroundColor = UIColor(red:0.96, green:0.49, blue:0.00, alpha:1.0).cgColor
        AcceptButton.setTitle("Accepted", for: .normal)
        OrderService.isAccepted(order: order, restId: "Hardee's")
    }
}
