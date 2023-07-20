//
//  AddMoreIngredientView.swift
//  MyRecipeApp
//
//  Created by owner on 20/07/2023.
//

import SwiftUI

struct AddMoreIngredientView: View {
    
    @Binding var showingAddMore: Bool
    @State var textString: String = ""
    @State private var noteText: String = "Enter notes..."
    var onAddValues: ((String) -> Void)?
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                GeometryReader {geometry in
                    TextEditor(text: $textString)
                        .frame(height: geometry.size.height)
                        .cornerRadius(10, antialiased: true)
                        .font(.body)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAddMore = false
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onAddValues?(textString)
                        showingAddMore = false
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct AddMoreIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoreIngredientView(showingAddMore: .constant(false))
    }
}
