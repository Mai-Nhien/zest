//
//  RecipeDetailViewController.swift
//  zest
//
//  Created by Mai on 4/12/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDetails: UILabel!
    var heading = ""
    var image = ""
    var details = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.text = heading
        recipeDetails.text = details
    }
}

