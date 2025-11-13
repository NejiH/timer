//
//  BackgroundView.swift
//  Blink
//
//  Created by Arnaud on 13/11/2025.
//

import SwiftUI

struct BackgroundView: View {
    
    var backgroundAsset: BackgroundAsset // On récupère les valeurs via l'enum
    
    var body: some View {
            Group {
                switch backgroundAsset {
                case .image(let name, _):
                    backgroundImage(named: name)
                case .video(let name, let type, _):
                    backgroundVideo(name: name, type: type)
                }
            }
        }
    
    @ViewBuilder
    func backgroundImage(named name: String) -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                Image(decorative: name)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    func backgroundVideo(name: String, type: String) -> some View {
        LoopingPlayerView(videoName: name, videoType: type)
            .ignoresSafeArea()
    }
}

#Preview {
    let viewModel = TimerViewModel()
    BackgroundView(backgroundAsset: viewModel.currentBackgroundAsset)
}
