//
//  MainView.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//

import SwiftUI

struct MainView: View {
    var viewModel = TimerViewModel()
    @Bindable var audioManager = AudioManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        Image(decorative: viewModel.currentBackgroundName)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                    .ignoresSafeArea()
                
                
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
                .environment(AudioManager.shared)
            }
        }
    }
}


#Preview {
    ZStack {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        MainView()
    }
}
