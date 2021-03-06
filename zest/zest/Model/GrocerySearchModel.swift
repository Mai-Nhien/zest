//
//  GrocerySearchModel.swift
//  zest
//
//  Created by Mai on 4/16/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import CoreLocation
import Keys

class GrocerySearchModel {
    var groceryStores: [PlaceData]
    let API_KEY = ZestKeys().placesKey
    static let shared = GrocerySearchModel()
    
    init() {
        groceryStores = []
    }
    
    // call Google Places API to get nearby grocery stores
    func fetchNearbyGroceryStores(coordinate: CLLocationCoordinate2D, radius: Double, onSuccess: @escaping ([PlaceData]) -> Void) {
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&types=grocery_or_supermarket|supermarket&key=\(API_KEY)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        print(urlString)
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        var placeResults: [PlaceData] = []
                        let results = try JSONDecoder().decode(PlaceResult.self, from: data)
                        placeResults = results.results
                        onSuccess(placeResults)
                    } catch {
                        exit(1)
                    }
                } else {
                    onSuccess([])
                }
            }.resume()
        }
    }
}
