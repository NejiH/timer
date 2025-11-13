//
//  BlinkApp.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//

import SwiftUI

@main
struct BlinkApp: App {
    @State private var viewModel = TimerViewModel()
    @State private var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .navigationBarTitleDisplayMode(.inline)
            }
            .environment(viewModel)
            .environment(audioManager)
        }
    }
}
