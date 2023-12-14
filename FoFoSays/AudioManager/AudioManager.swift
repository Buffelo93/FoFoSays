//
//  AudioManager.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/17/23.
//

import AVFAudio

final class AudioManager {
    
    private var audioPlayerDict: [AudioFile: AVAudioPlayer] = [:]
    var soundIsOn: Bool = true
    
    init() {
        for audio in AudioFile.allCases {
            populateAudioPlayerDict(audioFile: audio)
        }
    }
    
    func play(audioFile: AudioFile) {
        guard let audioPlayer = audioPlayerDict[audioFile], soundIsOn else { return }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func playTileSoundBy(index: Int) {
        switch index {
        case 0:
            play(audioFile: .tileSound1)
        case 1:
            play(audioFile: .tileSound2)
        case 2:
            play(audioFile: .tileSound3)
        case 3:
            play(audioFile: .tileSound4)
        default:
            break
        }
    }
    
    private func populateAudioPlayerDict(audioFile: AudioFile) {
        if let url = Bundle.main.url(forResource: audioFile.rawValue, withExtension: "mp3") {
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayerDict[audioFile] = audioPlayer
            } catch {
                print("Could not create audioplayer for \(audioFile.rawValue). Error: \(error.localizedDescription)")
            }
        }
    }

}


