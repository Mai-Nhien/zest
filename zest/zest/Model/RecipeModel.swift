//
//  RecipeModel.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation

class RecipeModel {
    static let shared = RecipeModel()
    var savedRecipes: [Recipe]
    var recipeResults: [Recipe]
    var fridge: [String]
    private var fileLocation: URL!
    let ACCESS_KEY = "052a4b2f0bef41138415628709c0d811"
    let BASE_URL = "https://api.spoonacular.com/"
    
    init () {
        savedRecipes = []
        recipeResults = []
        fridge = ["eggs", "milk", "flour"]
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        fileLocation = documentsDirectory.appendingPathComponent("recipes.json")
                
        // Does the file exist? If it does, load it!
        if FileManager.default.fileExists(atPath: fileLocation.path){
            load()
        // Else if it doesn't initialize with default values
        } else{
            savedRecipes.append(Recipe(title: "Pasta", image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", recipe: "tada"))
        }
    }
    
    private func load() {
        do {
            let data = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            savedRecipes = try decoder.decode([Recipe].self, from: data)
        } catch{
            print("err \(error)")
        }
    }
    
    private func save() {
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(savedRecipes)
            let jsonString = String(data: data, encoding: .utf8)!
            try jsonString.write(to: fileLocation, atomically: true, encoding: .utf8)
        } catch{
            print("err \(error)")
        }
    }
    
    func getSavedRecipes() -> [Recipe] {
        return savedRecipes
    }
    
    func getNewRecipes(onSuccess: @escaping ([Recipe]) -> Void) {
        if let url = URL(string: "\(BASE_URL)recipes/complexSearch") {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("Client-ID \(ACCESS_KEY)",
            forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        var tempRecipes: [Recipe] = []
                        tempRecipes = try JSONDecoder().decode([Recipe].self, from: data)
                        onSuccess(tempRecipes)
                    } catch {
                        exit(1)
                    }
                }
            }.resume()
        }
    }
}
