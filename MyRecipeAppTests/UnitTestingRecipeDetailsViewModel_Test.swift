//
//  UnitTestingRecipeDetailsViewModel_Test.swift
//  MyRecipeAppTests
//
//  Created by owner on 21/07/2023.
//

@testable import MyRecipeApp
import XCTest
import CoreData

class UnitTestingRecipeDetailsViewModel_Test: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_UnitTestingRecipeDetailsViewModel_updateRecipeSuccess() {
        
        let dataController = DataController()
        let moc = dataController.container.viewContext
        dataController.addRecipe(name: "Korean ramyeon with rice cake",
                                            ingredients:
                                               "2 packages of Korean instant ramyeon\n4 cups water\n1 cup rice cake slices\n½ cup fermented kimchi, chopped\n2 green onions, sliced diagonally\n2 eggs",
                                            steps:
                                               "\nOpen the ramyeon packages and take out the packets of soup powder and dried vegetables.\nIn a medium pot, combine water, kimchi, and rice cake slices. Cover the pot and bring it to a boil over medium high heat. Once it starts boiling, continue to cook for an additional 2 minutes. Add the packets of dried vegetables and only 1 packet of soup powder to the pot.\nAdd the noodles to the pot. Cover and cook for about 2 to 3 minutes, until the noodles are half untangled. Use a ladle or a large spoon to stir the ramyeon gently.",
                                            image: UIImage(named: "tteokramyeon")!,
                                            type: "main-course",
                                            context: moc)
        
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
        
        var recipes: [RecipeEntity] = []
        
        do {
            recipes = try moc.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let recipe = recipes.first else { return }
        
        let vm = RecipeDetailsViewModel(recipe: recipe)
        
        vm.name = "Ramyeon"
        
        vm.update(context: moc)
        
        XCTAssertTrue(vm.name == "Ramyeon")   
    }
}
