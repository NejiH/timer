//
//  MenuButton.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct MenuButton: View {
    @Bindable var viewModel: TimerViewModel
    @Bindable var audioManager: AudioManager
        
    var body: some View {
        ZStack {
            Menu {
                Picker("Durée concentration", selection: $viewModel.concentrationDuration) {
                    ForEach(viewModel.dureesMinutes, id: \.self) { minutes in
                        Text("\(minutes) min")
                            .tag(minutes * 60) 
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.concentrationDuration) {
                    viewModel.reinitialiseerAvecNouvelleDuree()
                    
                    let minutes = viewModel.concentrationDuration / 60
                    viewModel.annoncer(message: "Durée de concentration définie à \(minutes) minutes.")
                }
                .accessibilityLabel("Durée du temps de concentration")
                
                Picker("Durée pause", selection: $viewModel.pauseDuration) {
                    ForEach(viewModel.dureesMinutes, id: \.self) { minutes in
                        Text("\(minutes) min")
                            .tag(minutes * 60)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.pauseDuration) {
                    let minutes = viewModel.pauseDuration / 60
                    viewModel.annoncer(message: "Durée de pause définie à \(minutes) minutes.")
                }
                .accessibilityLabel("Durée du temps de pause")
                
                Divider()
                
                Toggle(isOn: $viewModel.isMusicEnabled) {
                    Label("Musique", systemImage: viewModel.isMusicEnabled ? "music.note" : "music.note.slash")
                }
                .onChange(of: viewModel.isMusicEnabled) {
                    if viewModel.isMusicEnabled {
                        if viewModel.isRunning {
                            audioManager.play(music: "music")
                        }
                        viewModel.annoncer(message: "Musique activée.")
                    } else {
                        audioManager.stop()
                        viewModel.annoncer(message: "Musique désactivée.")
                    }
                }
                .accessibilityLabel("Activer ou désactivier la musique")
                
            } label: {
               
                ZStack {
                   
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 30, height: 30)
                        .opacity(0)


                    Text("Réglages")
                        .font(.system(size: 20))
                        .foregroundStyle(viewModel.foregroundColor)
                }
            }
//            .buttonStyle(.glass)
            .accessibilityLabel("Options")
            .accessibilityHint("Ouvre un menu modifier les réglages de durée et de musique.")
           
        }
    }
}

#Preview {
    ZStack {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        
        MenuButton(viewModel: TimerViewModel(), audioManager: AudioManager())
    }
}
