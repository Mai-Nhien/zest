//
//  SignInUpViewController.swift
//  zest
//
//  Created by Mai on 4/29/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInUpViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTF.text, email.trimmingCharacters(in: .whitespacesAndNewlines) != "", let password = passwordTF.text, password.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    self.goToHome()
                }
            }
        } else {
           
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailTF.text, email.trimmingCharacters(in: .whitespacesAndNewlines) != "", let password = passwordTF.text, password.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil, let result = result {
                    let db = Firestore.firestore()
                    db.collection("users").document(result.user.uid).setData(["fridgeIngredients" : ["eggs"], "savedRecipes": ["title": "Pasta", "image": "https://spoonacular.com/recipeImages/716429-556x370.jpg", "recipe" : "Boil pasta for 9 minutes. Pick your favorite pasta sauce and saute noodles and sauce in a pan. Add garlic, salt, pepper to taste."]])
                    self.goToHome()
                }
            }
        } else {
           
        }
    }
    
    func goToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as? UITabBarController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
