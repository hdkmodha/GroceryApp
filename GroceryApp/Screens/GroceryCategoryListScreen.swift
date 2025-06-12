//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 12/06/25.
//

import SwiftUI
import Foundation


struct GroceryCategoryListScreen: View {
    
    @EnvironmentObject private var model: GroceryModels
    
    private func fetchGroceryCategories() async {
        do {
            try await model.getGroceryCategories()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(model.groceryCategories) { groceryCategory in
            HStack {
                Circle()
                    .fill(Color(hex: groceryCategory.colorCode, alpha: 1.0))
                    .frame(width: 25, height: 25)
                Text(groceryCategory.title)
            }
        }
        .task {
            await self.fetchGroceryCategories()
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    NavigationStack {
        GroceryCategoryListScreen()
            .environmentObject(GroceryModels())
    }
}

