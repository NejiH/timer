//
//  Timer.swift
//  Blink
//
//  Created by Mounir on 12/11/2025.
//

import SwiftUI

struct TimerView: View {
    
    var viewModel: TimerViewModel
    @Bindable var audioManager = AudioManager.shared

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text(viewModel.estEnPause ? "Pause" : "Concentration")
                    .font(.custom("Bebas Neue", size: 50))
                    .foregroundStyle(viewModel.estEnPause ? .green : viewModel.foregroundColor)
                    .accessibilityValue(viewModel.formatTempsPourVoiceOver(temps: viewModel.timeRemaining))
                    .accessibilityLabel("État actuel")

                Text(viewModel.formatTemps(temps: viewModel.timeRemaining))
                    .font(.custom("Bebas Neue", size: 120, relativeTo: .largeTitle))
                    .foregroundStyle(viewModel.foregroundColor)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: viewModel.timeRemaining)
                    .minimumScaleFactor(0.5)
                    .accessibilityValue(viewModel.formatTempsPourVoiceOver(temps: viewModel.timeRemaining))
                    .accessibilityLabel("Temps restant")

                HStack(spacing: 12) {
                    Button(action: {
                        if viewModel.isRunning  {
                            viewModel.mettreEnPause()
                            audioManager.pause()
                                
                            
                        } else {
                            viewModel.demarrer()
                            
                            if viewModel.isMusicEnabled {
                                if audioManager.audioPlayer == nil {
                                    audioManager.play(music: "music")
                                } else {
                                    audioManager.togglePlayPause()
                                }
                            }
                            

                        }
                        
                    }) {
                        PlayPauseButton(viewModel: viewModel)
                    }
                    .buttonStyle(.glass)
                    .accessibilityLabel(viewModel.isRunning ? "Mettre en pause le minuteur" : "Démarrer le minuteur")
                    .accessibilityHint("Appuyez pour \(viewModel.isRunning ? "mettre en pause" : "démarrer")")
                }
                
            }
            .padding()
        }
        .onDisappear {
            viewModel.invaliderMinuteur()
        }
    }
}

#Preview {
    TimerView(viewModel: TimerViewModel())
        .background(.black)
}

