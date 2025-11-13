//
//  TimerViewModel.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import Foundation
import UIKit
import SwiftUI

@Observable
class TimerViewModel {
    var concentrationDuration: Int = 25 * 60
    var pauseDuration: Int = 5 * 60

    var isMusicEnabled: Bool = true
    var timeRemaining: Int = 25 * 60

    var isRunning: Bool = false
    var estEnPause: Bool = false
    var minuteur: Foundation.Timer? = nil
    
    let dureesMinutes = [1, 5, 10, 15, 20, 25, 30, 45, 60]
    
    var currentBackgroundName: String = "background"
    var backgroundNames = ["background", "bgmoonmorning", "bgmoonday", "bgmoonnight", "bglight", "bgdark"]
    
    private let contrastMap: [String: BackgroundContrast] = [
        "background": .dark,
        "bgmoonmorning": .light,
        "bgmoonday": .light,
        "bgmoonnight": .dark,
        "bglight": .light,
        "bgdark": .dark
    ]
    
    var foregroundColor: Color {
        let contrastType = contrastMap[currentBackgroundName] ?? .dark
        
        switch contrastType {
        case .light :
            return .black
        case .dark :
            return .white
        }
    }
    
    init() {
        // Force l'initialisation correcte du timeRemaining
        self.timeRemaining = self.concentrationDuration
    }

    func getNextBackgroundName() {
        guard let currentIndex = backgroundNames.firstIndex(of: currentBackgroundName) else {
            currentBackgroundName = backgroundNames.first ?? "background"
            return
        }
        
        let nextIndex = (currentIndex + 1) % backgroundNames.count
        
        currentBackgroundName = backgroundNames[nextIndex]
    }
    
    func formatTemps(temps: Int) -> String {
        let minutes = temps / 60
        let seconds = temps % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func formatTempsPourVoiceOver(temps: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropLeading // Laisse tomber le zéro s'il n'y a que des minutes

        return formatter.string(from: TimeInterval(temps)) ?? "\(temps) secondes"
    }
    
    func reinitialiseerAvecNouvelleDuree() {
        if !isRunning {
            timeRemaining = concentrationDuration
        }
    }

    func demarrer() {
        guard !isRunning else { return }
        isRunning = true
        programmerHorloge()
        
        annoncer(message: "Minuteur démarré. Mode Concentration")
        feedbackHaptique(style: .medium)
    }

    func mettreEnPause() {
        isRunning = false
        invaliderMinuteur()
        
        annoncer(message: "Minuteur mis en pause")
        feedbackHaptique(style: .soft)
    }


    // Reglage du minuteur
    func programmerHorloge() {
        invaliderMinuteur()
        minuteur = Foundation.Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tictac()
        }
    }

    func invaliderMinuteur() {
        minuteur?.invalidate()
        minuteur = nil
    }

    func tictac() {
        guard isRunning else { return }

        if timeRemaining > 0 {
            timeRemaining -= 1
            
            
        } else {
            if estEnPause {
                invaliderMinuteur()
                isRunning = false
                estEnPause = false
                timeRemaining = concentrationDuration
                
                annoncer(message: "Fin de la pause, début du temps de concentration")
            } else {
                estEnPause = true
                timeRemaining = pauseDuration
                
                annoncer(message: "Fin du temps de concentration, début du temps de pause")
               
            }
        }
    }
    
    func annoncer(message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
    
    func feedbackHaptique(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

