//
//  RecipeDetailViewController.swift
//  zest
//
//  Created by Mai on 4/12/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDetails: UITextView!
    var saveButton: UIBarButtonItem!
    var heading = ""
    var image = ""
    var details = ""
    var data: String?
    var recipeIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.text = heading
        recipeDetails.text = details
        if image.count > 0 {
            let url = URL(string: image)
            recipeImage.kf.setImage(with: url)
        }
        if let imageString = data {
            if let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters){
                recipeImage.image = UIImage(data: imageData)
            }
        }
        
        if recipeIndex >= 0 {
            saveButton = UIBarButtonItem(title: "Save Recipe", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveRecipe))
            navigationItem.rightBarButtonItem = saveButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func saveRecipe() {
        RecipeModel.shared.appendRecipe(recipe: RecipeModel.shared.recipeResults[recipeIndex])
    }
}

