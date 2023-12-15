//
//  ColorsSheetViewModel.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/15/23.
//

import SwiftUI

final class ColorsSheetViewModel: ObservableObject {
    
    let gameLogic: GameLogic
    let colorSchemeDataSource = ColorSchemeDataSource()
    @Published var colorSchemeData: [ColorSchemeModel] = []
    @Published var didTap = false
    private let userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    
    init(gameLogic: GameLogic) {
        self.gameLogic = gameLogic
        colorSchemeData = colorSchemeDataSource.colorData
        let savedIndex = userDefaultsManager.getIntWith(key: .savedColorSchemeIndex)
        colorSchemeData[savedIndex].isSelected = true
    }
    
    func selectedColorScheme(index: Int) {
        colorSchemeData.forEach { $0.isSelected = false }
        colorSchemeData[index].isSelected = true
        userDefaultsManager.set(integer: index, key: .savedColorSchemeIndex)
        colorSchemeData = colorSchemeData
        gameLogic.setGameColorScheme(colors: colorSchemeData[index].colors)
    }
    
}
