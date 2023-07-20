//
//  AddRecipeView.swift
//  MyRecipeApp
//
//  Created by owner on 19/07/2023.
//

import SwiftUI

struct AddRecipeView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var showingAddRecipe: Bool
    
    @StateObject private var vm = AddRecipeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Text("Add Recipe".uppercased())
                        .font(.system(size: 24, weight: Font.Weight.medium))
                    Image(uiImage: vm.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                    
                    Button {
                        vm.showImagePicker.toggle()
                    } label: {
                        Text("Add photo")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .cornerRadius(16)
                    }
                    .sheet(isPresented: $vm.showImagePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image)
                    }
                    
                    Picker(selection: $vm.selectedRecipeType, label: Text("All")) {
                        ForEach(vm.recipeTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Enter recipe name...", text: $vm.name)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                    Text("Ingredients")
                        .font(.system(size: 18, weight: Font.Weight.medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        TextEditor(text: $vm.ingredientDescription)
                            .frame(height: 200)
                            .cornerRadius(10, antialiased: true)
                            .font(.body)
                            .padding(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                        
                        if vm.ingredientDescription.isEmpty {
                            TextEditor(text: $vm.ingredientDescPlaceholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                                .padding(5)
                        }
                    }
                    
                    Text("Steps")
                        .font(.system(size: 18, weight: Font.Weight.medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        TextEditor(text: $vm.stepsDescription)
                            .frame(height: 200)
                            .cornerRadius(10, antialiased: true)
                            .font(.body)
                            .padding(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                        
                        if vm.stepsDescription.isEmpty {
                            TextEditor(text: $vm.stepsDescPlaceholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                                .padding(5)
                        }
                    }
                    
                    Button {
                        vm.addRecipe(context: moc)
                        showingAddRecipe = false
                    } label: {
                        Text("SUBMIT")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding([.top, .bottom], 20)
                }
                .padding()
            }
            .toolbar {
                Button {
                    showingAddRecipe = false
                } label: {
                    Text("Done")
                }
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(showingAddRecipe: .constant(false))
    }
}
