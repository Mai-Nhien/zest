//
//  DiscoverTableViewController.swift
//  zest
//
//  Created by Mai on 4/13/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class DiscoverTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.rowHeight = 100.0
        tableView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100.0
        loadResults()
    }
    
    func loadResults() {
        RecipeModel.shared.getNewRecipes(onSuccess: {(recipeArray) in
            RecipeModel.shared.recipeResults = recipeArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeModel.shared.recipeResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")! as! DiscoverCell

        // Get the recipe object
        if RecipeModel.shared.recipeResults.count > 0 {
            let recipe = RecipeModel.shared.recipeResults[indexPath.row]
            let url = URL(string: recipe.image)
            cell.resultImage.kf.setImage(with: url)
            cell.resultTitle.text = recipe.title
        } else {
            cell.resultTitle.text = "No Recipes"
        }
       
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showResult" {
            let recipeVC = segue.destination as! RecipeDetailViewController
            if let selected = tableView.indexPathForSelectedRow?.row {
                let recipe = RecipeModel.shared.recipeResults[selected]
                recipeVC.heading = recipe.title
                recipeVC.image = recipe.image
                if let sourceRecipe = recipe.sourceUrl {
                    recipeVC.details = sourceRecipe
                }
                recipeVC.recipeIndex = selected
            }
        }
    }
}
