//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 10/06/25.
//

import Foundation
import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryCategoryScreen: View {
    @State private var title: String = ""
    @State private var colorCode: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var model: GroceryModels
    
    private func saveGroceryCategory() async {
        let groceryRequestDTO = GroceryCategoryRequestDTO(title: self.title, colorCode: self.colorCode)
        
        do {
            try await model.saveGroceryCategory(groceryRequestDTO)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        Form {
            TextField("title", text: $title)
            ColorSelectorView(colorCode: $colorCode)
                .navigationTitle("New Category")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task {
                                await self.saveGroceryCategory()
                            }
                        } label: {
                            Text("Save")
                        }
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        AddGroceryCategoryScreen()
            .environmentObject(GroceryModels())
    }
}
