//
//  MenuButton.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct MenuButton: View {
    var body: some View {
        ZStack {
            Menu {
                Button {
                    print("Enable geolocation")
                } label: {
                    Label("Réglage durée", systemImage: "clock.fill")
                }
                
                Button {
                    print("Enable geolocation")
                } label: {
                    Label("Activer la musique", systemImage: "music.note") // désactiver = music.note.slash
                }
            } label: {
               
                ZStack {
                   
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 50, height: 50)
                        .opacity(0)


                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
            }
           
            .buttonStyle(.glass)
           
        }
    }
}

#Preview {
    ZStack {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        
        MenuButton()
    }
}
