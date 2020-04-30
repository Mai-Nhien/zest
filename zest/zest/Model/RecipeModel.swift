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
    let ACCESS_KEY = "052a4b2f0bef41138415628709c0d811"
    let BASE_URL = "https://api.spoonacular.com/"
    
    init () {
        savedRecipes = []
        recipeResults = []
        fridge = ["eggs"]
    }
    
    private func save() {
        let accountData = AccountData(savedRecipes: savedRecipes, fridgeIngredients: fridge)
        if let user = Auth.auth().currentUser {
            RecipeModelService().save(uid: user.uid, accountData: accountData)
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
