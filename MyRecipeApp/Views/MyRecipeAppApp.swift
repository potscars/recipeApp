//
//  MyRecipeAppApp.swift
//  MyRecipeApp
//
//  Created by owner on 19/07/2023.
//

import SwiftUI

@main
struct MyRecipeAppApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            RecipeHomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
