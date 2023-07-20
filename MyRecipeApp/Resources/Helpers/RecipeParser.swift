//
//  RecipeParser.swift
//  MyRecipeApp
//
//  Created by owner on 21/07/2023.
//

import Foundation

class RecipeParser: NSObject {
    
    var recipeTypes: [String] = []
    
    class func fetchRecipeType(for data: Data, completion: @escaping ([String]?) -> Void) {
        
        let delegate = RecipeParser()
        let parser = XMLParser(data: data)
        parser.delegate = delegate
        parser.parse()
        
        DispatchQueue.main.async {
            completion(delegate.recipeTypes)
        }
    }
}

extension RecipeParser: XMLParserDelegate {
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "name" {
            guard let name = attributeDict["name"] else {
                return
            }
            recipeTypes.append(name.capitalized)
        }
    }
}
