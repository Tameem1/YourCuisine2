//
//  RestaurantViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/17/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import UIKit
class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView: UITableView!
    let foods = ["Burger", "Pizza", "Poteto"]
    
    var restaurant: Restaurant?
    @IBOutlet weak var OpenCloseTimeInDetails: UILabel!
    @IBOutlet weak var RestaurantNameInDetailes: UILabel!
    
    override func viewDidLoad() {
        self.TableView.dataSource = self
        self.TableView.delegate = self
        self.RestaurantNameInDetailes.text = restaurant?.RName
        self.OpenCloseTimeInDetails.text = restaurant?.OpenCloseTime
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetLocationViewController" {
            let destinationVC = segue.destination as! MyMapViewController
            let index = self.TableView.indexPathForSelectedRow?.row
            destinationVC.NewFood = foods[index!]
            destinationVC.restaurant = self.restaurant
        }
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = foods[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
    }
}
