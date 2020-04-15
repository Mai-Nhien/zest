//
//  Recipe.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation

struct Result: Codable {
    let results: [Recipe]
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Recipe: Equatable, Codable {
    var title: String
    var image: String?
    var sourceUrl: String?
    var recipe: String?
    var isCustom: Bool?
    var imageData: Data?
    
    init (title: String, image: String?, recipe: String, imageData: Data?) {
        self.title = title
        if let image = image {
            self.image = image
        } else {
            self.image = ""
        }
        if let imageData = imageData {
            self.imageData = imageData
        } else {
            self.imageData = nil
        }
        self.recipe = recipe
        self.sourceUrl = nil
        self.isCustom = true
    }
    
    init (from: Decodable, title: String, image: String, sourceUrl: String) {
        self.title = title
        self.image = image
        self.sourceUrl = sourceUrl
        self.recipe = nil
        self.isCustom = false
    }
}
