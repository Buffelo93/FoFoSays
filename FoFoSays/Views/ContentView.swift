//
//  ContentView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/15/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var gameLogic = GameLogic()
    
    var body: some View {
        RootView()
            .environmentObject(gameLogic)
    }

}

#Preview {
    ContentView()
}
