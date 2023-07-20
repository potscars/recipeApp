//
//  DataController.swift
//  MyRecipeApp
//
//  Created by owner on 20/07/2023.
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MyRecipeApp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data: - \(error.localizedDescription)")
            }
        }
        
        loadInitiateRecipes()
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error {
            print("Failed to save Recipe: - \(error.localizedDescription)")
        }
    }
    
    func addRecipe(name: String,
                   ingredients: String,
                   steps: String,
                   image: UIImage,
                   type: String,
                   context: NSManagedObjectContext) {
        
        self.checkIfRecipeExisted(name: name, ingredients: ingredients,
                                  steps: steps, image: image,
                                  type: type, context: context)
    }
    
    func updateRecipe(recipe: RecipeEntity,
                      name: String,
                      ingredients: String,
                      steps: String,
                      image: UIImage,
                      type: String,
                      context: NSManagedObjectContext) {
        recipe.name = name
        recipe.ingredients = ingredients
        recipe.steps = steps
        recipe.imageData = image.jpegData(compressionQuality: 1.0)
        recipe.type = type
        
        save(context: context)
    }
    
    private func stringArrayToData(with array: [String]) -> Data? {
        let arrayAsString = array.description
        return arrayAsString.data(using: .utf8)
    }
    
    private func checkIfRecipeExisted(name: String,
                                      ingredients: String,
                                      steps: String,
                                      image: UIImage,
                                      type: String,
                                      context: NSManagedObjectContext) {
        do {
            
            let request : NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", name)
            let numberOfRecords = try context.count(for: request)
            
            if numberOfRecords == 0 {
                
                let recipe = RecipeEntity(context: context)
                recipe.name = name
                recipe.ingredients = ingredients
                recipe.steps = steps
                recipe.imageData = image.jpegData(compressionQuality: 1.0)
                recipe.type = type
                
                try context.save()
            }
        } catch let error {
            
            print("Failed to save recipe: - \(error.localizedDescription)")
        }
    }
    
    private func loadInitiateRecipes() {
        
        let userDefault = UserDefaults.standard
        let isDataLoaded = userDefault.bool(forKey: "isDataLoaded")
        
        guard !isDataLoaded else {
            return
        }
        
        checkIfRecipeExisted(name: "Bibimguksu",
                             ingredients:
                                "4 ounces (about 110 grams) somyeon (thin wheat noodles)\n4 ounces fermented kimchi, chopped\n¼ cup kimchi brine (or cold water)\n2 tablespoons gochujang (Korean fermented hot pepper paste)\n1 teaspoon sugar (optional)\n1 garlic clove, minced\n½ cup worth cucumber, cut into matchsticks\n1 tablespoon toasted sesame oil\n1 tablespoon toasted sesame seeds, ground\n1 half-boiled egg (or hard-boiled egg)",
                             steps:
                                "Combine kimchi, kimchi brine, gochujang, sugar (if used), garlic, and sesame oil in a large bowl. Mix well with a spoon.\nBring a pot of water to a boil and add the noodles. Stir them with a wooden spoon and cover. Cook for about 3 minutes 30 seconds. Only a minute into the cooking, it may start boiling over. Just stir the noodles and crack the lid.\nTaste a sample to see if the noodles are nicely cooked or not. The noodles should be chewy but without anything hard inside.\nDrain the noodles in a strainer and rinse them in cold running water until they are cold and no longer slippery. Drain well and add to the kimchi mixture.\nMix everything well and transfer to a large bowl. Add the cucumber and the egg and sprinkle some sesame seeds over top. Serve right away.",
                             
                             image: UIImage(named: "bibimguksu")!,
                             type: "lunch",
                             context: container.viewContext)
        checkIfRecipeExisted(name: "Bibimbap",
                             ingredients:
                                "100g / 3.5 ounces beef mince (or other cuts)\n1 Tbsp soy sauce\n1 Tbsp sesame oil\n1 tsp brown sugar\n1/4 tsp minced garlic\n250g (0.6 pounds) seasoned spinach\n350g (0.8 pounds) seasoned bean sprouts\n100g (3.5 ounces) shiitake mushroom\n120g (4.2 ounces) carrots (1 small)"
                             ,
                             steps:
                                "For meat, mix the beef mince with the meat sauce listed above. Marinate the meat for about 30 mins while you are working on other ingredients to enhance the flavour. Add some cooking oil into a wok and cook the meat on medium high to high heat. It takes about 3 to 5 mins to thoroughly cook it.\nMix the bibimbap sauce ingredients in a bowl.\nCook spinach and bean sprouts per linked recipe."
                             ,
                             image: UIImage(named: "bibimbap1")!,
                             type: "dinner",
                             context: container.viewContext)
        checkIfRecipeExisted(name: "Korean ramyeon with rice cake",
                             ingredients:
                                "2 packages of Korean instant ramyeon\n4 cups water\n1 cup rice cake slices\n½ cup fermented kimchi, chopped\n2 green onions, sliced diagonally\n2 eggs",
                             steps:
                                "\nOpen the ramyeon packages and take out the packets of soup powder and dried vegetables.\nIn a medium pot, combine water, kimchi, and rice cake slices. Cover the pot and bring it to a boil over medium high heat. Once it starts boiling, continue to cook for an additional 2 minutes. Add the packets of dried vegetables and only 1 packet of soup powder to the pot.\nAdd the noodles to the pot. Cover and cook for about 2 to 3 minutes, until the noodles are half untangled. Use a ladle or a large spoon to stir the ramyeon gently.",
                             image: UIImage(named: "tteokramyeon")!,
                             type: "main-course",
                             context: container.viewContext)
        
        userDefault.setValue(true, forKey: "isDataLoaded")
    }
}
