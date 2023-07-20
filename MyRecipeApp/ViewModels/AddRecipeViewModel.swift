//
//  AddRecipeViewModel.swift
//  MyRecipeApp
//
//  Created by owner on 20/07/2023.
//

import Foundation
import UIKit
import CoreData

class AddRecipeViewModel: ObservableObject {
    
    @Published var image: UIImage = UIImage(named: "placeholder-image")!
    @Published var ingredientDescription = ""
    @Published var stepsDescription = ""
    @Published var name = ""
    @Published var stepsDescPlaceholder = "Enter steps to cook..."
    @Published var ingredientDescPlaceholder = "Enter ingredients..."
    @Published var recipeTypes: [String] = ["All"]
    @Published var selectedRecipeType: String = "All"
    
    @Published var showImagePicker = false
    
    init() {
        self.fetchDataFromXml()
    }
    
    func fetchDataFromXml() {
        let xmlURL = Bundle.main.url(forResource: "recipetypes", withExtension: "xml")
        
        guard let xmlURL = xmlURL else { return }
        
        do {
            let xmlData = try Data(contentsOf: xmlURL)
            RecipeParser.fetchRecipeType(for: xmlData) { [weak self] recipeType in
                guard let self = self else { return }
                guard let recipeType = recipeType else { return }
                self.recipeTypes.append(contentsOf: recipeType)
            }
            
        } catch let error {
            print("Error: - \(error.localizedDescription)")
        }
    }
    
    func addRecipe(context: NSManagedObjectContext) {
        DataController().addRecipe(name: name,
                                   ingredients: ingredientDescription,
                                   steps: stepsDescription,
                                   image: image, type: selectedRecipeType,
                                   context: context)
    }
}

