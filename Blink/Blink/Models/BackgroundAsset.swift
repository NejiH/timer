//
//  BackgroundAsset.swift
//  Blink
//
//  Created by Arnaud on 13/11/2025.
//

import Foundation

enum BackgroundAsset: CaseIterable, Equatable {
    case image(name: String, contrast: BackgroundContrast)
    case video(name: String, type: String, contrast: BackgroundContrast)
    
    // Définir la liste de tous les cas pour l'itération
    static var allCases: [BackgroundAsset] {
        return [
            .image(name: "background", contrast: .dark),
            .image(name: "bgmoonmorning", contrast: .light),
            .image(name: "bgmoonday", contrast: .light),
            .image(name: "bgmoonnight", contrast: .dark),
            .image(name: "bglight", contrast: .light),
            .image(name: "bgdark", contrast: .dark),
            .video(name: "bgvideo1", type: "mp4", contrast: .dark),
        ]
    }
    
    // Propriété calculée pour le contraste
    var contrastType: BackgroundContrast {
        switch self {
        case .image(_, let contrast):
            return contrast
        case .video(_, _, let contrast):
            return contrast
        }
    }
}


