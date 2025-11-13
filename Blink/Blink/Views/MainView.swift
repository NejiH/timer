//
//  MainView.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//h

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            BorderTimerView()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            VStack {
                Spacer()
                PlayPauseButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 8) {
                    ResetButton()
                    MenuButton()
                }
                .padding(.trailing, 70)
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
