//
//  BorderProgressView.swift
//  Blink
//
//  Created by Arnaud on 12/11/2025.
//

import SwiftUI

struct BorderProgressView: View {
    var progress: Double // 0 → 1
    var lineWidth: CGFloat = 4
    var color: Color = .green

    var body: some View {
        GeometryReader { geometry in
            let rect = CGRect(origin: .zero, size: geometry.size)
            let path = Path { path in
                path.addRect(rect)
            }

            path
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .animation(.linear(duration: 0.01), value: progress)
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    BorderProgressView(progress: )
//}
