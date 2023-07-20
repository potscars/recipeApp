//
//  RecipeRowView.swift
//  MyRecipeApp
//
//  Created by owner on 19/07/2023.
//

import SwiftUI
import UIKit

struct RecipeRowView: View {
    
    @ObservedObject var recipe: RecipeEntity
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: RecipeDetailsView(vm: RecipeDetailsViewModel(recipe: recipe))) {
                EmptyView()
            }
            .opacity(0)
            
            HStack {
                
                if recipe.imageData != nil {
                    Image(uiImage: UIImage(data: recipe.imageData!)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .cornerRadius(10)
                        .clipped()
                } else {
                    Image("bibimbap1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .cornerRadius(10)
                        .clipped()
                }
                
                Text(recipe.name ?? "unknown")
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .bold()
                Spacer()
            }
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 16)
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    .opacity(0.25)
            )
            
        }
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeRowView(recipe: RecipeEntity(context: DataController().container.viewContext))
    }
}
