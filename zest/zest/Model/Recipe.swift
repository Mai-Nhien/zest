//
//  Recipe.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation

struct AccountData: Codable {
    let savedRecipes: [Recipe]
    let fridgeIngredients: [String]
    private enum CodingKeys: String, CodingKey {
        case savedRecipes = "savedRecipes"
        case fridgeIngredients = "fridgeIngredients"
    }
    
    init (savedRecipes: [Recipe], fridgeIngredients: [String]) {
        self.savedRecipes = savedRecipes
        self.fridgeIngredients = fridgeIngredients
    }
    
    init (from: Decodable, savedRecipes: [Recipe], fridgeIngredients: [String]) {
        self.savedRecipes = savedRecipes
        self.fridgeIngredients = fridgeIngredients
    }
}

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
    
    init (title: String, image: String?, recipe: String) {
        self.title = title
        if let image = image {
            self.image = image
        } else {
            self.image = ""
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
