//
//  AudioManager.swift
//  Blink
//
//  Created by Arnaud Hayon on 12/11/2025.
//

import AVFoundation
import Observation

/// Cette classe gère la lecture de musique en utilisant AVAudioPlayer.
/// Elle utilise AVFoundation pour gérer les flux audio et Observation pour signaler les changements.
@Observable
class AudioManager {
    /// La variable partagée de la classe AudioManager, qui permet de partager une instance unique
    /// pour la lecture de musique à travers l'application.
    static let shared = AudioManager()
    
    /// Un pointeur vers un AVAudioPlayer qui contient l'audio à jouer.
    var audioPlayer: AVAudioPlayer?
    /// Un indicateur pour suivre si la musique est en cours de lecture.
    var isPlaying = false
    var shouldBePlaying: Bool = false
    
    /// Initialisateur privé pour empêcher la création d'instances multiples.
    init() {
    }
    
    /// Configure l'instance AVAudioSession pour permettre la lecture de musique.
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Erreur lors de la configuration de l'AVAudioSession: \(error)")
        }
    }
    
    /**
     Lance la lecture de musique à partir du fichier spécifié.
     
     - Parameter music: Le nom du fichier audio à lire, spécifié par son nom de fichier et son extension (par exemple, "track.mp3").
     */
    func play(music: String) {
        if let player = audioPlayer, !player.isPlaying {
            player.play()
            isPlaying = true
            shouldBePlaying = true
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
    
    /**
     Pause la lecture en cours de musique.
     */
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
        shouldBePlaying = false
    }
    
    /**
     Arrête la lecture et met à jour le point de temps à zéro.
     */
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        isPlaying = false
        shouldBePlaying = false
    }
    
    func stopForVideo() { // Nouvelle fonction pour un arrêt non permanent
        audioPlayer?.pause() // Utilisez pause pour garder la position de lecture
        isPlaying = false
        // shouldBePlaying n'est PAS modifié ici, il reste TRUE
    }
    
    func resumeFromVideo() { // Nouvelle fonction pour la reprise
        if shouldBePlaying { // Seulement si la musique DOIT être jouée
            audioPlayer?.play()
            isPlaying = true
        }
    }
    
    /**
     Change le statut de lecture/pause en un clic.
     */
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
