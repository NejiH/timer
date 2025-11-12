//
//  Timer.swift
//  Blink
//
//  Created by Mounir on 12/11/2025.
//

import SwiftUI

struct TimerView: View {
    
    var viewModel: TimerViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                // Phase Concentration - Pause
                Text(viewModel.estEnPause ? "Pause" : "Concentration")
                    .font(.headline)
                    .foregroundStyle(viewModel.estEnPause ? .green : .red)

                // Temps
                Text(viewModel.formatTemps(temps: viewModel.timeRemaining))
                    .font(.custom("Bebas Neue", size: 120))
                    .foregroundColor(.white)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: viewModel.timeRemaining)

                HStack(spacing: 12) {
                    Button(action: {
                        if viewModel.isRunning {
                            viewModel.mettreEnPause()
                        } else {
                            viewModel.demarrer()
                        }
                        
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .frame(width: 50, height: 50)
                                .opacity(0)

                            Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(.glass)
//                    Button(action:
//                            { viewModel.timeRemaining = viewModel.concentrationDuration
//                        viewModel.isRunning = false
//                        
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                                .frame(width: 50, height: 50)
//                                .opacity(0)
//                            Image(systemName: "arrow.clockwise")
//                                .font(.system(size: 20))
//                                .foregroundStyle(.white)
//                        }
//                    }
//                    .buttonStyle(.glass)
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
