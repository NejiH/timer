//
//  TimerViewModel.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import Foundation

@Observable
class TimerViewModel {
    let concentrationDuration: Int = 25 * 60
    let pauseDuration: Int = 5 * 60 

    var timeRemaining: Int = 60

    var isRunning: Bool = false
    var estEnPause: Bool = false
    var minuteur: Foundation.Timer? = nil

    func formatTemps(temps: Int) -> String {
        let minutes = temps / 60
        let seconds = temps % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func demarrer() {
        guard !isRunning else { return }
        isRunning = true
        programmerHorloge()
    }

    func mettreEnPause() {
        isRunning = false
        invaliderMinuteur()
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
            } else {
                estEnPause = true
                timeRemaining = pauseDuration
               
            }
        }
    }
}

