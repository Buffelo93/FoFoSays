//
//  GameLogic.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/17/23.
//

import SwiftUI

final class GameLogic: ObservableObject {
    
    var tiles = [GameTile(color: .green, isPressed: false),
                 GameTile(color: .red, isPressed: false),
                 GameTile(color: .yellow, isPressed: false),
                 GameTile(color: .blue, isPressed: false)]
    
    private var moveOrder: [Int] = [] {
        didSet {
            gameRound = moveOrder.count
        }
    }
    private var savedIndex: Int = 0
    private let audioManager: AudioManager = AudioManager()
    private let userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    private let transitionAnimation = Animation.easeInOut(duration: 0.5)
    
    @Published var playerCanTap: Bool = true
    @Published var textIsRed: Bool = false
    @Published var isGameOver: Bool = false
    @Published var gameRound: Int = 1
    @Published var highScore: Int
    @Published var soundIsOn: Bool
    
    init() {
        self.highScore = userDefaultsManager.getIntWith(key: .highScore)
        if userDefaultsManager.getBoolWith(key: .notFirstLaunch) {
            self.soundIsOn = userDefaultsManager.getBoolWith(key: .soundIsOn)
        } else {
            self.soundIsOn = true
            userDefaultsManager.set(bool: true, key: .notFirstLaunch)
        }
        audioManager.soundIsOn = soundIsOn
    }
    
    func startGame() {
        let randomInt = Int.random(in: 0..<4)
        moveOrder.append(randomInt)
        flashAnimation(with: randomInt)
        audioManager.playTileSoundBy(index: randomInt)
    }
    
    func resetGame() {
        updateHighScore()
        moveOrder.removeAll()
        savedIndex = 0
        textIsRed = false
        isGameOver = false
        gameRound = 1
    }
    
    func tilePressed(index: Int) {
        playerCanTap.toggle()
        if index == moveOrder[savedIndex] {
            audioManager.playTileSoundBy(index: index)
            flashAnimation(with: index) {
                if self.savedIndex+1 == self.moveOrder.count {
                    self.savedIndex = 0
                    self.wait(time: 0.25) {
                        self.nextRound()
                    }
                } else {
                    self.savedIndex += 1
                }
                self.playerCanTap.toggle()
            }
        } else {
            audioManager.play(audioFile: .incorrect)
            textIsRed = true
            incorrectAnimation(with: index) {
                withAnimation(self.transitionAnimation) {
                    self.isGameOver = true
                }
                self.playerCanTap.toggle()
            }
        }
    }
    
    func toggleSound() {
        soundIsOn.toggle()
        audioManager.soundIsOn = soundIsOn
        userDefaultsManager.set(bool: soundIsOn, key: .soundIsOn)
    }
    
}

private extension GameLogic {
    
    func nextRound() {
        playerCanTap.toggle()
        moveOrder.append(Int.random(in: 0..<4))
        var incrament = 0.5
        for move in moveOrder {
            wait(time: incrament) {
                self.audioManager.playTileSoundBy(index: move)
                self.flashAnimation(with: move)
            }
            incrament += 0.5
        }
        wait(time: incrament) {
            self.playerCanTap.toggle()
        }
    }
    
    func updateHighScore() {
        if gameRound-1 > highScore {
            userDefaultsManager.set(integer: gameRound-1, key: .highScore)
            highScore = gameRound-1
        }
    }
    
    func flashAnimation(with index: Int, completion: (() -> Void)? = nil) {
        let animation = Animation.easeInOut(duration: 0.25)
        withAnimation(animation) {
            tiles[index].isPressed.toggle()
        }
        wait(time: 0.2) {
            withAnimation(animation) {
                self.tiles[index].isPressed.toggle()
            }
            completion?()
        }
    }
    
    func incorrectAnimation(with index: Int, completion: (() -> Void)? = nil) {
        let animation = Animation.easeInOut(duration: 0.05).repeatCount(3)
        withAnimation(animation) {
            tiles[index].isPressed.toggle()
        }
        wait(time: 0.2) {
            withAnimation(animation) {
                self.tiles[index].isPressed.toggle()
            }
        }
        wait(time: 0.75) { completion?() }
    }
    
    func wait(time: Double, _ execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
    }
    
}
