//
//  AudioManager.swift
//  Blink
//
//  Created by Arnaud Hayon on 12/11/2025.
//

import AVFoundation
import Observation

@Observable
class AudioManager {
    static let shared = AudioManager()
    
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    
    init() {
//        try? AVAudioSession.sharedInstance().setCategory(.playback)
//        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Erreur lors de la configuration de l'AVAudioSession: \(error)")
        }
    }
    
    func play(music: String) {
        if let player = audioPlayer, !player.isPlaying {
            player.play()
            isPlaying = true
            return
        }
        
        setupAudioSession()
        
        guard let url = Bundle.main.url(forResource: music, withExtension: "mp3") else {
            print("❌ Fichier non trouvé")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.3
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("❌ Erreur: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        isPlaying = false
    }
    
    func togglePlayPause() {
        if let player = audioPlayer {
            if player.isPlaying {
                pause()
            } else {
                player.play()
                isPlaying = true
            }
        }
    }
}
