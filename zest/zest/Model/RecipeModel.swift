//
//  RecipeModel.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import FirebaseAuth

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
        fridge = ["eggs", "flour", "sugar"]
//        if let user = Auth.auth().currentUser {
//            if let ingredients = RecipeModelService().getFridge(uid: user.uid) {
//               fridge = ingredients
//            }
//        }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        fileLocation = documentsDirectory.appendingPathComponent("recipes.json")
        // Does the file exist? If it does, load it!
        if FileManager.default.fileExists(atPath: fileLocation.path){
            load()
        // Else if it doesn't initialize with default values
        } else{
            savedRecipes.append(Recipe(title: "Pasta", image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", recipe: "Boil pasta for 9 minutes. Pick your favorite pasta sauce and saute noodles and sauce in a pan. Add garlic, salt, pepper to taste.", imageData: nil))
        }
        
        
    }
    
    private func load() {
        do {
            let data = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            let accountData = try decoder.decode(AccountData.self, from: data)
            savedRecipes = accountData.savedRecipes
            //fridge = accountData.fridgeIngredients
        } catch{
            print("err \(error)")
        }
    }
    
    private func save() {
        do{
            let encoder = JSONEncoder()
            let accountData = AccountData(savedRecipes: savedRecipes, fridgeIngredients: fridge)
            let data = try encoder.encode(accountData)
            let jsonString = String(data: data, encoding: .utf8)!
            try jsonString.write(to: fileLocation, atomically: true, encoding: .utf8)
        } catch{
            print("err \(error)")
        }
    }
    
    func getSavedRecipes() -> [Recipe] {
        return savedRecipes
    }
    
    func appendRecipe(recipe: Recipe) {
        savedRecipes.append(recipe)
        save()
    }
    
    func deleteRecipe(index: Int) {
        savedRecipes.remove(at: index)
        save()
    }
    
    func appendIngredient(ingredient: String){
        fridge.append(ingredient)
        save()
    }
    
    func deleteIngredient(index: Int) {
        fridge.remove(at: index)
        save()
    }
    
    func getNewRecipes(onSuccess: @escaping ([Recipe]) -> Void) {
        let recipeList = fridge.joined(separator: ",")
        if let url = URL(string: "\(BASE_URL)recipes/complexSearch?includeIngredients=\(recipeList)&addRecipeInformation=true&apiKey=\(ACCESS_KEY)") {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        var tempRecipes: [Recipe] = []
                        let results = try JSONDecoder().decode(Result.self, from: data)
                        tempRecipes = results.results
                        onSuccess(tempRecipes)
                    } catch {
                        exit(1)
                    }
                }
            }.resume()
        }
    }
}
