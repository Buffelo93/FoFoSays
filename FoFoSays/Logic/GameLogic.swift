//
//  GameLogic.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/17/23.
//

import SwiftUI
import AudioToolbox

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
    
    @Published var currentColorScheme: [Color]
    @Published var gameRound: Int = 1
    @Published var highScore: Int
    @Published var soundIsOn: Bool
    @Published var playerCanTap: Bool = true
    @Published var textIsRed: Bool = false
    @Published var isGameOver: Bool = false {
        didSet {
            if isGameOver, soundIsOn {
                audioManager.unMuteVolumeFor(audioFile: .gameOver)
            } else {
                audioManager.muteVolumeFor(audioFile: .gameOver)
            }
        }
    }
    
    init() {
        self.highScore = userDefaultsManager.getIntWith(key: .highScore)
        self.currentColorScheme = colorSchemeData[userDefaultsManager.getIntWith(key: .savedColorSchemeIndex)].colors
        if userDefaultsManager.getBoolWith(key: .notFirstLaunch) {
            self.soundIsOn = userDefaultsManager.getBoolWith(key: .soundIsOn)
        } else {
            self.soundIsOn = true
            userDefaultsManager.set(bool: true, key: .notFirstLaunch)
        }
        audioManager.soundIsOn = soundIsOn
        audioManager.loopMusic(for: .drive)
        if !soundIsOn {
            audioManager.muteVolumeFor(audioFile: .drive)
        }
        setGameColorScheme(colors: currentColorScheme)
    }
    
    func startGame() {
        audioManager.muteVolumeFor(audioFile: .drive)
        wait(time: 0.5) {
            let randomInt = Int.random(in: 0..<4)
            self.moveOrder.append(randomInt)
            self.flashAnimation(with: randomInt)
            self.audioManager.playTileSoundBy(index: randomInt)
        }
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
            if soundIsOn { AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) }
            incorrectAnimation(with: index) {
                withAnimation(self.transitionAnimation) {
                    self.isGameOver = true
                }
                self.audioManager.loopMusic(for: .gameOver)
                self.playerCanTap.toggle()
            }
        }
    }
    
    func toggleSound() {
        soundIsOn.toggle()
        audioManager.soundIsOn = soundIsOn
        userDefaultsManager.set(bool: soundIsOn, key: .soundIsOn)
        if soundIsOn {
            audioManager.unMuteVolumeFor(audioFile: .drive)
        } else {
            audioManager.muteVolumeFor(audioFile: .drive)
        }
    }
    
    func playMainMenuMusic() {
        if soundIsOn {
            audioManager.unMuteVolumeFor(audioFile: .drive)
        }
    }
    
    func setGameColorScheme(colors: [Color]) {
        var newTiles: [GameTile] = []
        for color in colors {
            newTiles.append(GameTile(color: color, isPressed: false))
        }
        tiles = newTiles
        currentColorScheme = colors
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
