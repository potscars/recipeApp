//
//  RecipeDetailsView.swift
//  MyRecipeApp
//
//  Created by owner on 19/07/2023.
//

import SwiftUI
import UIKit

struct RecipeDetailsView: View {
    
    @State var vm: RecipeDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    //Dclare here because in vm, the value is not changing
    @State var showingAddIngredientMore = false
    @State var showingAddStepMore = false
    @State var showImagePicker = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if #available(iOS 15.0, *) {
                    listView
                        .listRowSeparator(.hidden)
                } else {
                    // Fallback on earlier versions
                    listView
                        .onAppear() {
                            UITableView.appearance().separatorStyle = .none
                        }
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Delete") {
                vm.deleteRecipe(context: moc)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var listView: some View {
        ScrollView {
            VStack {
                
                Image(uiImage: vm.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    Text("Change photo")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .cornerRadius(16)
                }
                .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image)
                }
                
                TextEditor(text: $vm.name)
                    .frame(height: 40)
                    .cornerRadius(10, antialiased: true)
                    .font(.system(size: 24, weight: .bold))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Ingredients")
                        .font(.system(size: 20, weight: Font.Weight.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 5)
                    
                    Button {
                        showingAddIngredientMore.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .sheet(isPresented: $showingAddIngredientMore) {
                        AddMoreIngredientView(showingAddMore: $showingAddIngredientMore, textString: vm.ingredients) { returnedString in
                            vm.addNewIngredients(with: returnedString)
                        }
                    }
                }
                
                Text(vm.ingredients)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
                
                HStack {
                    
                    Text("Steps to cook")
                        .font(.system(size: 20, weight: Font.Weight.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .bottom], 10)
                    
                    Button {
                        showingAddStepMore.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .sheet(isPresented: $showingAddStepMore) {
                        AddMoreStepView(showingAddMore: $showingAddStepMore, textString: vm.steps) { returnedString in
                            vm.addNewSteps(with: returnedString)
                        }
                    }
                }
                
                Text(vm.steps)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
                
                Button {
                    vm.update(context: moc)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("SAVE")
                        .font(.system(size: 20, weight: .bold))
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding([.top, .bottom], 20)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(vm: RecipeDetailsViewModel(recipe: RecipeEntity(context: DataController().container.viewContext)))
    }
}
