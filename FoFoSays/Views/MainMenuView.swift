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
    @Binding var showColorSheet: Bool
    
    var body: some View {
        ZStack {
            MainMenuBackgroundView(colors: gameLogic.currentColorScheme)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("FoFo Says")
                        .font(.system(size: 54.0))
                        .padding()
                    Text("High Score:")
                    Text("\(gameLogic.highScore) Rounds")
                    Spacer()
                    Button("Play") {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            showGameView = true
                        }
                    }
                    .buttonStyle(.automatic)
                    .font(.system(size: 46.0))
                    Button("Color Scheme") {
                        showColorSheet = true
                    }
                    .padding()
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
                    .padding(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
        }
        .font(.title)
        .fontWeight(.ultraLight)
        .foregroundStyle(.black)
    }
    
}

#Preview {
    MainMenuView(showGameView: .constant(false), showColorSheet: .constant(false))
        .environmentObject(GameLogic())
}

struct MainMenuBackgroundView: View {
    
    @State private var startAnimation: Bool = false
    var colors: [Color]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: colors,
                startPoint: startAnimation ? .topLeading : .bottomLeading,
                endPoint: startAnimation ? .bottomTrailing : .topTrailing
            )
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
        }
    }
    
}
