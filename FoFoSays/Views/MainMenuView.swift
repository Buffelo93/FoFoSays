//
//  MainMenuView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/21/23.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var gameLogic: GameLogic
    @Binding var showGameView: Bool
    let animation = Animation.easeInOut(duration: 0.5)
    
    var body: some View {
        ZStack {
                MainMenuBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("FOFO Says")
                        .font(.largeTitle)
                        .padding()
                    Text("High Score:")
                    Text("\(gameLogic.highScore) Rounds")
                    Spacer()
                    Button("Play") {
                        withAnimation(animation) {
                            showGameView = true
                        }
                    }
                    .buttonStyle(.automatic)
                    .font(.largeTitle)
                    Button {
                        gameLogic.toggleSound()
                    } label: {
                        if gameLogic.soundIsOn {
                            Image(systemName: "speaker.wave.3")
                        } else {
                            Image(systemName: "speaker.slash")
                        }
                        
                    }
                    .imageScale(.large)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    Spacer()
                }
        }
        .font(.title)
        .fontWeight(.light)
        .foregroundStyle(.black)
    }
    
}

#Preview {
    MainMenuView(showGameView: .constant(false))
        .environmentObject(GameLogic())
}

struct MainMenuBackgroundView: View {
    
    @State private var startAnimation: Bool = false
    
    var body: some View {
        // Animated background using ZStack and LinearGradient
        ZStack {
            LinearGradient(
                colors: [.red, .blue, .yellow, .green],
                startPoint: startAnimation ? .topLeading : .bottomLeading,
                endPoint: startAnimation ? .bottomTrailing : .topTrailing
            )
            // Animation to toggle the gradient colors
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
        }
    }
    
}
