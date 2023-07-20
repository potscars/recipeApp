//
//  RecipeDetailsViewModel.swift
//  MyRecipeApp
//
//  Created by owner on 20/07/2023.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    
    @Published var ingredients: String = ""
    @Published var steps: String = ""
    @Published var name: String = ""
    @Published var image = UIImage(named: "placeholder-image")!
    private var recipe: RecipeEntity
    
    init(recipe: RecipeEntity) {
        self.recipe = recipe
        self.manageData()
    }
    
    private func manageData() {
        
        ingredients = recipe.ingredients ?? ""
        steps = recipe.steps ?? ""
        
        if let imageData = recipe.imageData {
            image = UIImage(data: imageData) ?? UIImage()
        }
        
        name = recipe.name ?? ""
    }
    
    func update(context: NSManagedObjectContext) {
        DataController().updateRecipe(recipe: recipe,
                                      name: name,
                                      ingredients: ingredients,
                                      steps: steps,
                                      image: image,
                                      type: recipe.type ?? "unknown",
                                      context: context)
    }
    
    func addNewIngredients(with value: String) {
        ingredients = value
    }
    
    func addNewSteps(with value: String) {
        steps = value
    }
    
    func deleteRecipe(context: NSManagedObjectContext) {
        context.delete(recipe)
        DataController().save(context: context)
    }
}
