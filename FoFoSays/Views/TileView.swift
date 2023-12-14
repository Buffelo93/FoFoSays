//
//  TileView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/15/23.
//

import SwiftUI

struct TileView: View {
    
    @ObservedObject var gameTile: GameTile
    
    var body: some View {
        Rectangle()
            .fill(gameTile.isPressed ? gameTile.color.opacity(0.6) : gameTile.color)
    }
    
}

#Preview {
    TileView(gameTile: GameTile(color: .blue, isPressed: false))
}
