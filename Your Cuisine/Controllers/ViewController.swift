/*
 * Copyright 2016 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
import Foundation
import UIKit
import FirebaseDatabase

class ViewController: UITableViewController {
    var myOrders: [Orders] = []

//    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView2.delegate = self
//        self.tableView2.dataSource = self
        
        
        

        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

       
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = Database.database().reference().child("restaurants").child("tameem's Pizza").child("Orders")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            var newOrders: [Orders] = []
            for child in snapshot.children {
                let newOrder = Orders(snapshot: child as! DataSnapshot)
                newOrders.append(newOrder!)
            }
            self.myOrders = newOrders.sorted(by: {$0.Order < $1.Order})
            self.tableView.reloadData()
        })
        
    }
    
    
    // 1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrders.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! ListCellViewController
        
        
       cell.addressLabel.text = myOrders[indexPath.row].username
        
      
        
        return cell
        
    }
    @IBAction func acceptButtonTapped(_ sender: Any) {
    }
}
