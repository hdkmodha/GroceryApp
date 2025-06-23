//
//  Extension+String.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
