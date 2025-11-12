//
//  TimerBorderExample.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct TimerBorderExample: View {
    @State private var progress: Double = 0
    @State private var timer: Timer?
    @State private var startDate: Date?
    @State private var timerActive = false

    let duration: TimeInterval = 10 // secondes

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            BorderProgressView(progress: progress, lineWidth: 6, color: .green)

            VStack(spacing: 20) {
                Text("Border Progress Timer")
                    .foregroundStyle(.white)
                    .font(.headline)

                Button(timerActive ? "Stop" : "Start") {
                    if timerActive {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
    }

    func startTimer() {
        progress = 0
        timerActive = true
        startDate = Date()

        // Crée un Timer qui met à jour `progress` toutes les 0.1 secondes
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { t in
            guard let startDate else { return }
            let elapsed = Date().timeIntervalSince(startDate)
            let newProgress = min(elapsed / duration, 1.0)
            progress = newProgress

            if newProgress >= 1.0 {
                t.invalidate()
                timerActive = false
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerActive = false
        progress = 0
    }
}

#Preview {
    TimerBorderExample()
}
