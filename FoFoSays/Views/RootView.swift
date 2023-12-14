//
//  RootView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/14/23.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var gameLogic: GameLogic
    @State private var showGameView = false
    
    var body: some View {
        ZStack {
            MainMenuView(showGameView: $showGameView).zIndex(0)
            if showGameView {
                GameView().zIndex(1)
            }
            if gameLogic.isGameOver {
                GameOverView(showGameView: $showGameView).zIndex(2)
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(GameLogic())
}
