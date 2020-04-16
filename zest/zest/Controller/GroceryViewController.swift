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

class GroceryViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager  = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.0
        
        // Request permission for user's location
        locationManager.requestWhenInUseAuthorization()
        
        
//        // Create the annoation for blue bottle // 34.0762717,-118.3723989
//        let coordinate = CLLocationCoordinate2D(latitude: 34.0762717, longitude: -118.3723989)
//        let blueBottle = Location(coordinate: coordinate)
//        
//        // Add the annotation to the map view
//        mapView.addAnnotation(blueBottle)
//        mapView.setCenter(coordinate, animated: false)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        print("location update lat: \(location.coordinate.latitude) long: \(location.coordinate.longitude)")
    }
}
