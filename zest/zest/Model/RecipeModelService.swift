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

    func getFridge(uid: String) {
        let docRef = db.collection("uers").document(uid)
        docRef.getDocument { (document, error) in
            if let error = error {
                return
            }
            
        }

    }
}
