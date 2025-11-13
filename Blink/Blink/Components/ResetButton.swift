//
//  ResetButton.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct ResetButton: View {
    
    var viewModel: TimerViewModel
    @Bindable var audioManager = AudioManager.shared

    var body: some View {
        
            Button(action:
                    { viewModel.timeRemaining = viewModel.concentrationDuration
                viewModel.isRunning = false
                viewModel.estEnPause = false
                audioManager.stop()
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 30, height: 30)
                        .opacity(0)
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                        .foregroundStyle(viewModel.foregroundColor)
                        
                }
            }
//            .buttonStyle(.glass)
            .accessibilityLabel("Réinitialiser le minuteur")
            .accessibilityHint("Remet le temps à la durée de concentration initiale.")
    }
}

#Preview {
    ZStack {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        ResetButton(viewModel: TimerViewModel())
    }
}
