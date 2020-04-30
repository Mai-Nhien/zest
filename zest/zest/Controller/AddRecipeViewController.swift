//
//  AddRecipeViewController.swift
//  zest
//
//  Created by Mai on 4/14/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import Foundation
import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var recipeTV: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadImageButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set properties
        recipeTV.delegate = self
        titleTF.delegate = self
        saveButton.isEnabled = false
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .photoLibrary
        
        let singleTap = UITapGestureRecognizer(target: self,
        action: #selector(singleTappedRecognized))
        self.view.addGestureRecognizer(singleTap)
    }
    
    @objc func singleTappedRecognized (recognizer: UITapGestureRecognizer) {
        if recipeTV.isFirstResponder {
            recipeTV.resignFirstResponder()
        }
        if titleTF.isFirstResponder {
            titleTF.resignFirstResponder()
        }
    }
    
    func enableSubmitButton(viewText: String, fieldText: String) {
        self.saveButton.isEnabled = (viewText.count > 0
            && fieldText.count > 0 && uploadImageView.image != nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        if let title = titleTF.text {
            if let recipeView = recipeTV.text, let textRange = Range(range, in: recipeView) {
                let updatedText = recipeView.replacingCharacters(in: textRange,
                with: string)
                if updatedText != "" {
                    enableSubmitButton(viewText: recipeView, fieldText: title)
                } else {
                    saveButton.isEnabled = false
                }
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
        titleTF.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        if let titleText = titleTF.text {
            if let recipe = recipeTV.text {
                enableSubmitButton(viewText: recipe, fieldText: titleText)
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        titleTF.text = ""
        recipeTV.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if let title = titleTF.text, let recipe = recipeTV.text, let data = uploadImageView.image?.pngData() {
            RecipeModel.shared.appendRecipe(recipe: Recipe(title: title, image: nil, recipe: recipe, imageData: data.base64EncodedString(options: .endLineWithLineFeed)))
        }
        titleTF.text = ""
        recipeTV.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
            uploadImageView.image = newImage
            if let view = recipeTV.text, let field = titleTF.text {
                enableSubmitButton(viewText: view, fieldText: field)
            }
        } else {
            return
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker:
        UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}
