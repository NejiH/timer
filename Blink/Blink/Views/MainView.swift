//
//  MainView.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//

import SwiftUI

struct MainView: View {
    @Environment(TimerViewModel.self) private var viewModel
    @Environment(AudioManager.self) private var audioManager
    
    var body: some View {
        ZStack {
            // Image de fond
            Image(viewModel.currentBackgroundName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Bordure de progression
            BorderTimerView(viewModel: viewModel)
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            // Timer centré
            TimerView(viewModel: viewModel, audioManager: audioManager)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ResetButton(viewModel: viewModel, audioManager: audioManager)
                
                Menu {
                    Picker("Durée concentration", selection: Binding(
                        get: { viewModel.concentrationDuration },
                        set: { viewModel.concentrationDuration = $0 }
                    )) {
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
                    
                    Picker("Durée pause", selection: Binding(
                        get: { viewModel.pauseDuration },
                        set: { viewModel.pauseDuration = $0 }
                    )) {
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
                    
                    Divider()
                    
                    Toggle(isOn: Binding(
                        get: { viewModel.isMusicEnabled },
                        set: { viewModel.isMusicEnabled = $0 }
                    )) {
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
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(viewModel.foregroundColor)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        MainView()
            .navigationBarTitleDisplayMode(.inline)
    }
    .environment(TimerViewModel())
    .environment(AudioManager())
}
