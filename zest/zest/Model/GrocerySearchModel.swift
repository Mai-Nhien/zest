//
//  GrocerySearchModel.swift
//  zest
//
//  Created by Mai on 4/16/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import CoreLocation

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

class GrocerySearchModel {
    var groceryStores: [PlaceData]
    let API_KEY = "AIzaSyCyfC5LF58QGmrEToRJQ7oG-2bZei_d2u4"
    static let shared = GrocerySearchModel()
    
    init() {
        groceryStores = []
    }
    
    func fetchNearbyGroceryStores(coordinate: CLLocationCoordinate2D, radius: Double, onSuccess: @escaping ([PlaceData]) -> Void) {
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&types=grocery_or_supermarket|supermarket&key=\(API_KEY)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        print(urlString)
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        print(data.prettyPrintedJSONString)
                        var placeResults: [PlaceData] = []
                        let results = try JSONDecoder().decode(PlaceResult.self, from: data)
                        placeResults = results.results
                        onSuccess(placeResults)
                    } catch {
                        print("OH NO")
                        exit(1)
                    }
                }
            }.resume()
        }
    }
}
