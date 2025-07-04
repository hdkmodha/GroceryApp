//
//  UsedDefaults+Extension.swift
//  GroceryApp
//
//  Created by Hardik Modha on 12/06/25.
//

import Foundation


extension UserDefaults {
    
    var userId: UUID? {
        get {
            guard let userId  = string(forKey: Constants.userId) else { return nil }
            return UUID(uuidString: userId)
        }
        set {
            set(newValue?.uuidString, forKey: Constants.userId)
            synchronize()
        }
    }
    
    var token: String? {
        get {
            let value = string(forKey: Constants.token)
            return value
        }
        set {
            setValue(newValue, forKey: Constants.token)
            synchronize()
        }
    }
}
