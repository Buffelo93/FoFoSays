//
//  ColorsSheetViewModel.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/15/23.
//

import SwiftUI

final class ColorsSheetViewModel: ObservableObject {
    
    let gameLogic: GameLogic
    @Published var colorSchemes: [ColorSchemeModel] = []
    private let userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    
    init(gameLogic: GameLogic) {
        self.gameLogic = gameLogic
        let savedIndex = userDefaultsManager.getIntWith(key: .savedColorSchemeIndex)
        self.colorSchemes = colorSchemeData
        colorSchemeData[savedIndex].isSelected = true
    }
    
    func selectedColorScheme(index: Int) {
        colorSchemes.forEach { $0.isSelected = false }
        colorSchemes[index].isSelected = true
        userDefaultsManager.set(integer: index, key: .savedColorSchemeIndex)
        colorSchemes = colorSchemes
        gameLogic.setGameColorScheme(colors: colorSchemes[index].colors)
    }
    
}
