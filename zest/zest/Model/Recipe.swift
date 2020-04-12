//
//  Recipe.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation

struct Recipe: Equatable, Codable {
    var title: String
    var image: String
    var sourceUrl: String?
    var spoonacularSourceUrl: String?
    var recipe: String?
    var isCustom: Bool
    
    init (title: String, image: String, recipe: String) {
        self.title = title
        self.image = image
        self.recipe = recipe
        self.sourceUrl = nil
        self.spoonacularSourceUrl = nil
        self.isCustom = true
    }
    
    init (from: Decodable, title: String, image: String, sourceUrl: String, spoonacularSourceUrl: String) {
        self.title = title
        self.image = image
        self.sourceUrl = sourceUrl
        self.spoonacularSourceUrl = spoonacularSourceUrl
        self.recipe = nil
        self.isCustom = false
    }
}