//
//  MainView.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//

import SwiftUI

struct MainView: View {
    var viewModel = TimerViewModel()
    
    var body: some View {
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
