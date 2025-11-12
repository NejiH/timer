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
                    Label("Detect Location", systemImage: "location.circle")
                }
                
                Button {
                    print("Enable geolocation")
                } label: {
                    Label("Detect Location", systemImage: "location.circle")
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
