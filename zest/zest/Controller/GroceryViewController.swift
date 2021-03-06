//
//  GroceryViewController.swift
//  zest
//
//  Created by Mai on 4/15/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class GroceryViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    let locationManager  = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.0
        
        // Request permission for user's location
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        loadStores()
        
    }
    
    // load stores again
    @IBAction func refreshLocations(_ sender: UIBarButtonItem) {
        loadStores()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            manager.startUpdatingLocation()
        }
    }
    
    // if location changes, update user location and load stores again
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let startMarker = Location(coordinate: location.coordinate, title: "Start Point")
            mapView.addAnnotation(startMarker)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            loadStores()
        }
    }
    
    // call google places api and get groceries within 1000 meters
    func loadStores() {
        if let userCoordinate = locationManager.location?.coordinate {
            GrocerySearchModel.shared.fetchNearbyGroceryStores(coordinate: userCoordinate, radius: 1000, onSuccess: {(storeArray) in
                       GrocerySearchModel.shared.groceryStores = storeArray
                       DispatchQueue.main.async {
                        //self.displayStores()
                            let stores = GrocerySearchModel.shared.groceryStores
                            for store in stores {
                                let pin = Location(coordinate: CLLocationCoordinate2D(latitude: store.geometry.location.lat, longitude: store.geometry.location.lng), title: store.name)
                                self.mapView.addAnnotation(pin)
                            }
                       }
                   })
        }
    }
    
    // display a pin for each grocery
    func displayStores() {
        let stores = GrocerySearchModel.shared.groceryStores
        for store in stores {
            let pin = Location(coordinate: CLLocationCoordinate2D(latitude: store.geometry.location.lat, longitude: store.geometry.location.lng), title: store.name)
            mapView.addAnnotation(pin)
        }
    }
}
