//
//  RecipeViewController.swift
//  zest
//
//  Created by Mai on 4/12/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class RecipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return RecipeModel.shared.savedRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = CellWidth * CellCount
//        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
//
    override func willTransition(to newCollection: UITraitCollection,
        with coordinator: UIViewControllerTransitionCoordinator) {
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let orientation = UIDevice.current.orientation
            if orientation == .portrait{
                layout.scrollDirection = .vertical
            } else {
                layout.scrollDirection = .horizontal
            }
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCell
        let image = RecipeModel.shared.savedRecipes[indexPath.row]
        let url = URL(string: image.image)
        cell.recipeImage.kf.setImage(with: url)
        cell.recipeLabel.text = image.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue,
    sender: Any?) {
//        if segue.identifier == "loadImage" {
//            let dest = segue.destination as! ImageDetailViewController
//            // Get selected item
//            let indexPath = photoCollectionView.indexPathsForSelectedItems!.first!.row
//            dest.selectedImage = ImageModel.shared.images[indexPath]
//        }
    }
}
