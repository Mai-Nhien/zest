//
//  RecipeTableViewController.swift
//  zest
//
//  Created by Mai on 4/12/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class RecipeTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.rowHeight = 100.0
        tableView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100.0
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // if the model has changed, refresh the table
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Fridge"), object: nil, queue: nil) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "SavedRecipes"), object: nil, queue: nil) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "AddCustom"), object: nil, queue: nil) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeModel.shared.savedRecipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")! as! TableViewCell

        // Get the recipe object
        if RecipeModel.shared.savedRecipes.count > 0 {
            let recipe = RecipeModel.shared.savedRecipes[indexPath.row]
            if let image = recipe.image {
                let url = URL(string: image)
                cell.recipeImage.kf.setImage(with: url)
            }
            cell.recipeTitle.text = recipe.title
        } else {
            cell.recipeTitle.text = "No Recipes"
        }
       
        return cell
    }

  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RecipeModel.shared.deleteRecipe(index: indexPath.row)
//             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showRecipe" {
            let recipeVC = segue.destination as! RecipeDetailViewController
            if let selected = tableView.indexPathForSelectedRow?.row {
                let recipe = RecipeModel.shared.savedRecipes[selected]
                recipeVC.heading = recipe.title
                if let image = recipe.image {
                    recipeVC.image = image
                }
                // if custom then display recipe, else display recipe URL
                if let check = recipe.isCustom, check == true, let recipeDetails = recipe.recipe {
                    recipeVC.details = recipeDetails
                } else {
                    if let recipeUrl = recipe.sourceUrl {
                        recipeVC.details = recipeUrl
                    }
                }
                recipeVC.recipeIndex = -1
            }
        }
    }

}
