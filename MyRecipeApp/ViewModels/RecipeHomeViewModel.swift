//
//  RecipeHomeViewModel.swift
//  MyRecipeApp
//
//  Created by owner on 20/07/2023.
//

import Foundation

class RecipeHomeViewModel: ObservableObject {
    
    @Published var recipeTypes: [String] = ["All"]
    @Published var selectedRecipeType = "All"
    @Published var showingAddRecipe = false
    
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
                print(self.recipeTypes)
            }
            
        } catch let error {
            print("Error: - \(error.localizedDescription)")
        }
    }
}
