//
//  PlayPauseButton.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct PlayPauseButton: View {
    var viewModel: TimerViewModel
    
    var body: some View {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 50, height: 50)
                        .opacity(0)

                    Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(viewModel.foregroundColor)
                }       
    }
}

#Preview {
    ZStack {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        PlayPauseButton(viewModel: TimerViewModel())
    }
}
