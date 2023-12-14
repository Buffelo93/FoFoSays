//
//  GameTile.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/17/23.
//

import SwiftUI

final class GameTile: ObservableObject {
    
    let color: Color
    @Published var isPressed: Bool = false
    
    init(color: Color, isPressed: Bool) {
        self.color = color
        self.isPressed = isPressed
    }
    
}
