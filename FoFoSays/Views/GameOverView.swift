//
//  GameOverView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/13/23.
//

import SwiftUI

struct GameOverView: View {
    
    @EnvironmentObject var gameLogic: GameLogic
    @Binding var showGameView: Bool
    let animation = Animation.easeInOut(duration: 0.5)
    
    var body: some View {
        ZStack {
            GameOverBackgroundView()
            VStack {
                Spacer()
                Text("Game Over")
                    .font(.system(size: 54.0))
                    .padding()
                Text("Score: \(gameLogic.gameRound)")
                Button("Play Again") {
                    withAnimation(animation) {
                        gameLogic.resetGame()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.gameLogic.startGame()
                        }
                    }
                }
                .buttonStyle(.automatic)
                .padding()
                Button("Back to Menu") {
                    showGameView = false
                    withAnimation(animation) {
                        gameLogic.resetGame()
                        gameLogic.playMainMenuMusic()
                    }
                }
                .buttonStyle(.automatic)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .font(.largeTitle)
        .fontWeight(.ultraLight)
        .foregroundStyle(.black)
    }
}

#Preview {
    GameOverView(showGameView: .constant(false))
        .environmentObject(GameLogic())
}

struct GameOverBackgroundView: View {
    
    @State private var startAnimation: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .yellow, .green, .red,]), center: .center, startRadius: startAnimation ? 0 : 250, endRadius: startAnimation ? 250 : 1000)
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
        }
    }
    
}
