//
//  ListCellViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/21/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
class ListCellViewController: UITableViewCell {
    
    

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var AcceptButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func AcceptButtonTapped(_ sender: Any) {
        AcceptButton.layer.backgroundColor = UIColor(red:0.96, green:0.49, blue:0.00, alpha:1.0).cgColor
        AcceptButton.setTitle("Accepted", for: .normal)
    }
}
