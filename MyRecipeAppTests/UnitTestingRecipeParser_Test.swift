//
//  UnitTestingRecipeParser_Test.swift
//  MyRecipeAppTests
//
//  Created by owner on 21/07/2023.
//

@testable import MyRecipeApp
import XCTest

class UnitTestingRecipeParser_Test: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_UnitTestingRecipeParser_successFetchXMLData() {
        let xmlURL = Bundle.main.url(forResource: "recipetypes", withExtension: "xml")
        
        guard let xmlURL = xmlURL else { return }
        
        do {
            let xmlData = try Data(contentsOf: xmlURL)
            RecipeParser.fetchRecipeType(for: xmlData) { recipeType in
                XCTAssertNotNil(recipeType)
            }
        } catch let error {
            print("Error: - \(error.localizedDescription)")
        }
    }
}
