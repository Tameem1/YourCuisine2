//
//  CustomerViewController.swift
//  Your Cuisine
//
//  Created by Make school on 8/15/17.
//  Copyright © 2017 Make school. All rights reserved.
//


import UIKit
import FirebaseDatabase

class CustomerViewController : UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var NameRestaurantList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var restaurants: [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        let ref = Database.database().reference().child("restaurants")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            var newRestaurants = [Restaurant]()
            for child in snapshot.children {
                let newRestaurant = Restaurant(snapshot: child as! DataSnapshot)
                newRestaurants.append(newRestaurant!)
            }
            self.restaurants = newRestaurants.sorted(by: {$0.RName < $1.RName})
            self.tableView.reloadData()
        })
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cells
        
//        if indexPath.row == 0 {
//            cell.hardeezImage.image = UIImage(named: StringConstants.hardeezImageName)
////            print("photo")
//            print(indexPath.row)
//        }
        cell.RestaurantNameList.text = restaurants[indexPath.row].RName
        cell.OpenCloseLabel.text = restaurants[indexPath.row].OpenCloseTime
        
        cell.backgroundColor = UIColor(white:0.95,alpha: 1)
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToDetails" {
            let destinationVC = segue.destination as! RestaurantViewController
            let index = self.tableView.indexPathForSelectedRow?.row
            destinationVC.restaurant = self.restaurants[index!]
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        let ref = Database.database().reference().child("restaurants")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let m = snapshot.value as? String
            self.NameRestaurantList.text = m
        })
    }
    
}
