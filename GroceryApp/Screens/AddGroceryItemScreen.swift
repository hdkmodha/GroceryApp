//
//  AddGroceryItemScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 15/06/25.
//

import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryItemScreen: View {
    
    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Int? = nil
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var model: GroceryModels
    let groceryCategoryResponseDTO: GroceryCategoryResponseDTO
    
    
    private var isFormValid: Bool {
        guard let price, let quantity else {
            return false
        }
        
        return !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }
    
    private func saveGroceryItem() async {
        
        guard let price, let quantity else {
            return
        }
        
        let requestItemDTO = GroceryItemRequestDTO(title: self.title, price: price, quantity: quantity)
        do {
             try await model.saveGroceryItem(withId: groceryCategoryResponseDTO.id, andRequestDTO: requestItemDTO)
            dismiss()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Price", value: $price, format: .currency(code: Locale.current.currencySymbol ?? ""))
            TextField("Quantity", value: $quantity, format: .number)
        }
        .navigationTitle("New Grocery Item")
        .navigationBarTitleDisplayMode(.inline)
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
                        await saveGroceryItem()
                    }
                } label: {
                    Text("Save")
                }
                .disabled(!isFormValid)
            }
        }
        
    }
}

//#Preview {
//    NavigationStack {
//        AddGroceryItemScreen()
//    }
//}
