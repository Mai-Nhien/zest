//
//  Location.swift
//  zest
//
//  Created by Mai on 4/16/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct PlaceResult: Codable {
    var results: [PlaceData]
}

struct PlaceData: Codable {
    var name: String!
    var geometry: PlaceLocation
}

struct PlaceLocation: Codable {
    var location: Coordinates
}

struct Coordinates: Codable {
    var lat: Double
    var lng: Double
}

class Location: NSObject, MKAnnotation {
    var name: String!
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, name: String) {
        self.coordinate = coordinate
        self.name = name
    }

}
