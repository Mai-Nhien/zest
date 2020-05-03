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

class SignInUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        emailTF.delegate = self
        passwordTF.delegate = self
        let singleTap = UITapGestureRecognizer(target: self,
               action: #selector(singleTappedRecognized))
               self.view.addGestureRecognizer(singleTap)
    }
    
    @objc func singleTappedRecognized (recognizer: UITapGestureRecognizer) {
        if emailTF.isFirstResponder {
            emailTF.resignFirstResponder()
        }
        if passwordTF.isFirstResponder {
            passwordTF.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
        if emailTF.isFirstResponder {
           emailTF.resignFirstResponder()
        }
        if passwordTF.isFirstResponder {
           passwordTF.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        // if both fields are filled out, login
        if let email = emailTF.text, email.trimmingCharacters(in: .whitespacesAndNewlines) != "", let password = passwordTF.text, password.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil, let result = result {
                    // load the user's data into the model
                    RecipeModelService().loadFridge(uid: result.user.uid)
                    RecipeModelService().loadSavedRecipes(uid: result.user.uid)
                    self.goToHome()
                } else {
                    self.errorAlert(message: "Please check your credentials and try again.")
                }
            }
        } else {
           errorAlert(message: "Please check to make sure you entered an email and a password.")
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        // if both fields are filled out, register the user
        if let email = emailTF.text, email.trimmingCharacters(in: .whitespacesAndNewlines) != "", let password = passwordTF.text, password.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil, let result = result {
                    let db = Firestore.firestore()
                    db.collection("users").document(result.user.uid).setData(["fridgeIngredients" : ["eggs"], "savedRecipes": [["title": "Pasta", "isCustom": true, "image": "https://spoonacular.com/recipeImages/716429-556x370.jpg", "recipe": "Boil pasta for 9 minutes. Pick your favorite pasta sauce and saute noodles and sauce in a pan. Add garlic, salt, pepper to taste."]]])
                    // load the user's data into the model
                    RecipeModelService().loadFridge(uid: result.user.uid)
                    RecipeModelService().loadSavedRecipes(uid: result.user.uid)
                    self.goToHome()
                } else {
                    self.errorAlert(message: "Please choose a password over 6 characters.")
                }
            }
        } else {
            errorAlert(message: "Please check to make sure you entered an email and a password.")
        }
    }
    
    // show error for incorrect password, insufficient fields
    func errorAlert(message: String) {
        let alertController = UIAlertController(title: "Oops! Something went wrong.",
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // display first view controller
    func goToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as? UITabBarController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
