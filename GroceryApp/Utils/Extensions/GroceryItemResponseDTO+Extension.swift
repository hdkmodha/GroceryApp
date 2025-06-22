//
//  GroceryItemResponseDTO+Extension.swift
//  GroceryApp
//
//  Created by Hardik Modha on 15/06/25.
//

import GroceryAppSharedDTO

extension GroceryItemResponseDTO: @retroactive Identifiable, @retroactive Equatable, @unchecked @retroactive Sendable {
    public static func == (lhs: GroceryItemResponseDTO, rhs: GroceryItemResponseDTO) -> Bool {
        return lhs.id == rhs.id
    }
}
