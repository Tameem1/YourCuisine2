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

import UIKit
import GoogleMaps
import GooglePlacePicker
import FirebaseAuth
import FirebaseDatabase
class MyMapViewController: UIViewController, GMSPlacePickerViewControllerDelegate {
    
     var restaurant: Restaurant?
//    @IBOutlet weak var RestaurantNameInLocation: UILabel!
    var NewFood : String?
    var newOrder: Orders?
    
    @IBOutlet weak var AddressLabel: UITextField!
    @IBOutlet weak var TheLocation: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var TheOrder: UILabel!
   
    
    @IBOutlet weak var TheOrderName: UILabel!
    @IBOutlet weak var LocationTextField: UITextField!
    
//    @IBOutlet weak var mapView: UIView!
    
//    @IBOutlet weak var nextButton: UIButton!
    
    
    
//    override func loadView() {
//        let center = CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.2099)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001,
//                                               longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001,
//                                               longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: 33.899005, longitude: 35.479116, zoom: 15.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        //        self.mapView = mapView
//        //        let testFrame : CGRect = CGRect(x: 0, y: 200, width: 300, height: 200)
//        //        mapView.frame = testFrame
//        //        self.view.addSubview(mapView)
//        view = mapView
//        
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 33.899005, longitude: 35.479116)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
        
        
        
        if label.text == "" {
            var myAlert1 = UIAlertController(title: "Error", message: "You don't pick place on the Map", preferredStyle: UIAlertControllerStyle.alert);
            let okAction1 = UIAlertAction(title: "Ok", style:UIAlertActionStyle.default)
            
            myAlert1.addAction(okAction1);
            self.present(myAlert1, animated: true, completion: nil);
        }
            
        else{
            var myAlert = UIAlertController(title: "Note", message: "When you click Ok the Order will be send", preferredStyle: UIAlertControllerStyle.alert)
            
            let restaurantname = self.restaurantNameLabel.text
            let Order = TheOrder.text
            let Location = TheLocation.text
            let Address = AddressLabel.text
            
            
            let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.default){
                (ACTION) in
                
                
                
                let userData = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUser) as? Data
                let user = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? User
                let username = user?.username
                let phoneNumber = user?.phoneNumber
                
                
                self.newOrder = Orders(username: username!, Order: Order!, Location: Location!, phoneNumber: phoneNumber!, Address: Address!, orderInKitchen: false, orderAccepted: false, orderInWay: false)
                
                OrderService.create(RestaurantId: restaurantname!, username: username!, phoneNumber: phoneNumber! , Order: Order!, Location: Location!, Address: Address!, orderAccepted: false , orderInKitchen: false, orderInWay: false , completion: { (Order) in
                    print("the order")
                })
                self.performSegue(withIdentifier: Constants.Segue.toOrderStatus, sender: self)
            }
            
            
            let cancelAction = UIAlertAction(title: "cancel", style:UIAlertActionStyle.cancel){
                (ACTION) in
                print("Cancel button Tapped")
            }
            myAlert.addAction(okAction);
            myAlert.addAction(cancelAction);
            self.present(myAlert, animated: true, completion: nil);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restaurantNameLabel.text = restaurant?.RName
        self.view.addSubview(self.restaurantNameLabel)
        
        self.TheOrder?.text = NewFood

        
//        
//        let ref = Database.database().reference().child(Constants.UserDefaults.RName).child("restaurants/RName")
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            let m = snapshot.value as? String
//            self.RestaurantName.text = m
//        })
//        

        
    }
    
    @IBAction func PickPlaceButtonTapped(_ sender: Any) {
}
    @IBOutlet weak var label: UILabel!
    
    
    
    // The code snippet below shows how to create and display a GMSPlacePickerViewController.
    @IBAction func pickPlace(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(place.name)")
        print("Place address \(place.formattedAddress)")
        print("Place attributions \(place.attributions)")
        
         self.label.text = "\(place.name) \n \(place.formattedAddress)"
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.Segue.toOrderStatus
    {
        let nextviewcontroller = segue.destination as! OrderStausViewController
        nextviewcontroller.order = self.newOrder
    
        
        }
    }
}
