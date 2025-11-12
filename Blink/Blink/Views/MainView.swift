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
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                TimerView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 8) {
                    ResetButton(viewModel: viewModel)
                    MenuButton()
                }
                .padding(.trailing, 70)
            }
            .environment(AudioManager.shared)
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
