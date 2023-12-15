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
    
    // TODO: Remove stop if I'm not being used anywhere later
    func stop(audioFile: AudioFile) {
        guard let audioPlayer = audioPlayerDict[audioFile], soundIsOn else { return }
        audioPlayer.setVolume(0.0, fadeDuration: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            audioPlayer.stop()
        }
    }
    
    func muteVolumeFor(audioFile: AudioFile) {
        guard let audioPlayer = audioPlayerDict[audioFile] else { return }
        audioPlayer.setVolume(0.0, fadeDuration: 0.25)
    }
    
    func unMuteVolumeFor(audioFile: AudioFile) {
        guard let audioPlayer = audioPlayerDict[audioFile] else { return }
        audioPlayer.setVolume(1.0, fadeDuration: 0.75)
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
    
    func loopMusic(for audioFile: AudioFile) {
        guard let audioPlayer = audioPlayerDict[audioFile] else { return }
        audioPlayer.numberOfLoops =  -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
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


