//
//  PlayPauseButton.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct PlayPauseButton: View {
    
    @State private var isPlaying: Bool = false

    var body: some View {
        Group {
            if isPlaying {
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .accessibilityLabel("Pause")
                }
            } else {
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .accessibilityLabel("Play")
                }
            }
        }
    }
}

#Preview {
    PlayPauseButton()
}
