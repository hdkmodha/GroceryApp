//
//  GroceryDetailScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 15/06/25.
//

import Foundation
import GroceryAppSharedDTO
import SwiftUI

struct GroceryDetailScreen: View {
    
    var groceryCategoryDTO: GroceryCategoryResponseDTO
    @EnvironmentObject private var model: GroceryModels
    
    func fetchGroceryItems() async {
        
        do {
            try await model.getGroceryItems(forCategoryWithId: groceryCategoryDTO.id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            List(model.groceryItems, id: \.id) { groceryItem in
                HStack {
                    Text(groceryItem.title)
                    Spacer()
                    HStack {
                        Text("Quantity: \(groceryItem.quantity)")
                        Text("Price: \(groceryItem.price)")
                    }
                }
            }
            .navigationTitle(groceryCategoryDTO.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        model.groceryCategory = groceryCategoryDTO
                    } label: {
                        Text("Add Grocery Item")
                    }

                }
            }
            .sheet(item: $model.groceryCategory) { groceryCategory in
                NavigationStack {
                    AddGroceryItemScreen(groceryCategoryResponseDTO: groceryCategory)
                }
            }
            .task {
                await fetchGroceryItems()
            }
        }
    }
}

#Preview {
    NavigationStack {
        GroceryDetailScreen(groceryCategoryDTO: GroceryCategoryResponseDTO(id: UUID(), title: "Indian", colorCode: "#FFFF00"))
            .environmentObject(GroceryModels())
    }
}
