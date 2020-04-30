//
//  RecipeModelService.swift
//  zest
//
//  Created by Mai on 4/29/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RecipeModelService {
    let db = Firestore.firestore()

    func loadFridge(uid: String) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
           if let document = document {
                if let fridge = document.data()?["fridgeIngredients"] as? [String] {
                    RecipeModel.shared.fridge = fridge
                }
            }
        }
    }
    
    func loadSavedRecipes(uid: String) {
        
    }
}
