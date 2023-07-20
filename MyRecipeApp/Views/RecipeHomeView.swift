//
//  RecipeHomeView.swift
//  MyRecipeApp
//
//  Created by owner on 19/07/2023.
//

import SwiftUI

struct RecipeHomeView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var recipes: FetchedResults<RecipeEntity>
    
    @StateObject private var vm = RecipeHomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(recipes, id: \.self) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                    .onDelete { offset in
                        offset.map { recipes[$0] }.forEach(moc.delete)
                        DataController().save(context: moc)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Recipe App")
            .toolbar {
                
                Picker(selection: $vm.selectedRecipeType, label: Text("All")) {
                    ForEach(vm.recipeTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Button {
                    vm.showingAddRecipe.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $vm.showingAddRecipe) {
                    AddRecipeView(showingAddRecipe: $vm.showingAddRecipe)
                }
            }
        }
    }
}

struct RecipeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHomeView()
    }
}
