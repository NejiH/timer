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
        
        NavigationStack {
            ZStack {
                
                BackgroundView(backgroundAsset: viewModel.currentBackgroundAsset)
                
                    // Bordure de progression
                BorderTimerView(viewModel: viewModel)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                
                VStack {
                    TimerView(viewModel: viewModel)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        ResetButton(viewModel: viewModel)
                        ChangeBackgroundButton(viewModel: viewModel)
                    }
                    ToolbarSpacer(.fixed, placement: .topBarTrailing)
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        MenuButton(viewModel: viewModel, audioManager: audioManager)
                    }
                }
            }
        }
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
