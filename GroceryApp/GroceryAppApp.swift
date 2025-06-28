//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Hardik Modha on 05/06/25.
//

import SwiftUI

@main
struct GroceryAppApp: App {
    
    @StateObject var groceryModel = GroceryModels()
    
    var body: some Scene {
        WindowGroup {
            AuthRouter.start()
        }
    }
}
