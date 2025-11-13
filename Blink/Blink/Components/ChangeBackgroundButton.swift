//
//  ChangeBackgroundButton.swift
//  Blink
//
//  Created by Arnaud Hayon on 13/11/2025.
//

import SwiftUI

struct ChangeBackgroundButton: View {
    
    var viewModel: TimerViewModel
        
    var body: some View {
            Button(action: {
                viewModel.getNextBackgroundAsset()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 30, height: 30)
                        .opacity(0)

                    Image(systemName: "paintbrush")
                        .font(.system(size: 20))
                        .foregroundStyle(viewModel.foregroundColor)
                }
            }
//            .buttonStyle(.glass)
            .accessibilityLabel("Fond d'écran.")
            .accessibilityHint("Bouton pour changer le fond d'écran.")
    }
}

#Preview {
    ChangeBackgroundButton(viewModel: TimerViewModel())
}
