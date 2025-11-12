//
//  MainView.swift
//  Blink
//
//  Created by Thibault on 12/11/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Image(systemName: "eye")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Blink app!")
        }
        .padding()
    }
}

#Preview {
    MainView()
}
