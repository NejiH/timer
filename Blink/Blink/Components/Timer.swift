//
//  Timer.swift
//  Blink
//
//  Created by Mounir on 12/11/2025.
//

import SwiftUI

struct TimerView: View {
    
    private let concentrationDuration: Int = 10 // 10 secondes
    private let pauseDuration: Int = 10 // 10 secondes

    @State private var timeRemaining: Int = 10

    // État
    @State private var isRunning: Bool = false
    @State private var estEnPause: Bool = false

    @State private var minuteur: Foundation.Timer? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                // Phase Concentration - Pause
                Text(estEnPause ? "Pause" : "Concentration")
                    .font(.headline)
                    .foregroundStyle(estEnPause ? .green : .red)

                // Temps
                Text(formatTemps(temps: timeRemaining))
                    .font(.custom("Bebas Neue", size: 120))
                    .foregroundColor(.black)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: timeRemaining)

                HStack(spacing: 16) {
                    Button(action: {
                        if isRunning {
                            mettreEnPause()
                        } else {
                            demarrer()
                        }
                    })
                    {
                        Text(isRunning ? "Pause" : "Start")
                    }

                }
                .font(.title3)
            }
            .padding()
        }
        
        .onDisappear {
            invaliderMinuteur()
        }
    }

    // Format du temps
    func formatTemps(temps: Int) -> String {
        let minutes = temps / 60
        let seconds = temps % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func demarrer() {
        guard !isRunning else { return }
        isRunning = true
        programmerHorloge()
    }

    private func mettreEnPause() {
        isRunning = false
        invaliderMinuteur()
    }


    // Reglage du minuteur
    private func programmerHorloge() {
        invaliderMinuteur()
        minuteur = Foundation.Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            tictac()
        }
    }

    private func invaliderMinuteur() {
        minuteur?.invalidate()
        minuteur = nil
    }

    private func tictac() {
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

#Preview {
    TimerView()
}
