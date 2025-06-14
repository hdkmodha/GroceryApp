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
    @Environment(NavigationViewModel.self) private var viewModel
    
    @State var presentSheet: Bool = false
    
    private func fetchGroceryCategories() async {
        do {
            try await model.getGroceryCategories()
        } catch {
            print(error)
        }
    }
    
    private func deleteGroceryCategory(at offset: IndexSet) {
        offset.forEach { index in
            let groceryCategory = model.groceryCategories[index]
            Task {
                do {
                    try await model.deleteGroceryCategory(withId: groceryCategory.id)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(model.groceryCategories) { groceryCategory in
                HStack {
                    Circle()
                        .fill(Color(hex: groceryCategory.colorCode, alpha: 1.0))
                        .frame(width: 25, height: 25)
                    Text(groceryCategory.title)
                }
            }
            .onDelete(perform: deleteGroceryCategory)
        }
        .task {
            await self.fetchGroceryCategories()
        }
        
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.presentSheet = true
                } label: {
                    Text("Add New Category")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("Logout")
                }
            }
        }
        .sheet(isPresented: self.$presentSheet) {
            NavigationStack {
                AddGroceryCategoryScreen()
            }
        }
    }
}

#Preview {
    NavigationStack {
        GroceryCategoryListScreen()
            .environmentObject(GroceryModels())
    }
}

