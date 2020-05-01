//
//  RecipeModelService.swift
//  zest
//
//  Created by Mai on 4/29/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecipeModelService {
    let db = Firestore.firestore()

    func loadFridge(uid: String) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
           if let document = document {
                if let fridge = document.data()?["fridgeIngredients"] as? [String] {
                    RecipeModel.shared.fridge = fridge
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Fridge")))
                }
            }
        }
    }
    
    func loadSavedRecipes(uid: String) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document {
                let result = try? document.data(as: AccountData.self)
                if let recipes = result?.savedRecipes {
                    RecipeModel.shared.savedRecipes = recipes
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "SavedRecipes")))
                }
            }
        }
    }
    
    func save(uid: String, accountData: AccountData) {
        do {
            try db.collection("users").document(uid).setData(from: accountData)
        } catch let error {
            print("Error writing to Firestore: \(error)")
        }
    }
}
