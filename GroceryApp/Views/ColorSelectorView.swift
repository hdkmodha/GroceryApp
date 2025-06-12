//
//  ColorSelectorView.swift
//  GroceryApp
//
//  Created by Hardik Modha on 10/06/25.
//

import SwiftUI

enum Colors: String, CaseIterable {
    case yellow = "#FFFF00"
    case red = "#FF0000"
    case blue = "#0000FF"
    case orange = "#FFA500"
    case purple = "#A020F0"
}

struct ColorSelectorView: View {
    
    @Binding var colorCode: String
    
    var body: some View {
        HStack {
            ForEach(Colors.allCases, id: \.rawValue) { color in
                VStack {
                    Image(systemName: color.rawValue == colorCode ? "record.circle.fill" : "circle.fill" )
                        .font(.title)
                        .foregroundStyle(Color(hex: color.rawValue, alpha: 1.0))
                        .clipShape(Circle())
                        .onTapGesture {
                            self.colorCode = color.rawValue
                        }
                }
                
            }
        }
    }
}

#Preview {
    ColorSelectorView(colorCode: .constant(Colors.purple.rawValue))
}

