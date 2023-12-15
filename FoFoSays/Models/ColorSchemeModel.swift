//
//  ColorSchemeModel.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/15/23.
//

import SwiftUI

final class ColorSchemeModel: ObservableObject, Equatable, Hashable {
    
    let colors: [Color]
    let title: String
    var isSelected: Bool = false
    let index: Int
    
    init(colors: [Color], title: String, index: Int) {
        self.colors = colors
        self.title = title
        self.index = index
    }
    
    static func == (lhs: ColorSchemeModel, rhs: ColorSchemeModel) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
}
