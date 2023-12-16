//
//  GameView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/15/23.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameLogic: GameLogic
    
    var body: some View {
        ZStack {
            GameBackgroundView()
            TilesView(gameLogic: gameLogic)
            RoundDisplayView(roundCount: gameLogic.gameRound, textIsRed: gameLogic.textIsRed)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gameLogic.startGame()
            }
        }
        .allowsHitTesting(gameLogic.playerCanTap)
    }
    
}

#Preview {
    GameView()
        .environmentObject(GameLogic())
}

struct TilesView: View {
    
    @ObservedObject var gameLogic: GameLogic
    
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 1) {
                TileView(gameTile: gameLogic.tiles[0])
                    .onTapGesture {
                        gameLogic.tilePressed(index: 0)
                    }
                TileView(gameTile: gameLogic.tiles[1])
                    .onTapGesture {
                        gameLogic.tilePressed(index: 1)
                    }
            }
            HStack(spacing: 1) {
                TileView(gameTile: gameLogic.tiles[2])
                    .onTapGesture {
                        gameLogic.tilePressed(index: 2)
                    }
                TileView(gameTile: gameLogic.tiles[3])
                    .onTapGesture {
                        gameLogic.tilePressed(index: 3)
                    }
            }
        }
    }
    
}

struct RoundDisplayView: View {
    
    var roundCount: Int
    var textIsRed: Bool
    
    var textColor: Color {
        textIsRed ? Color.red : Color.white
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: 125, height: 125, alignment: .center)
            VStack {
                Text("Round")
                Text(String(roundCount))
            }
            .font(.largeTitle)
            .fontWeight(.ultraLight)
            .foregroundStyle(textColor)
        }
    }
    
}

struct GameBackgroundView: View {
    
    var body: some View {
        Rectangle()
            .fill(.black)
    }
    
}
