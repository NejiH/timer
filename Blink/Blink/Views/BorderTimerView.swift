    //
    //  BorderTimerView.swift
    //  Blink
    //
    //  Created by Thibault on 12/11/2025.
    //

import SwiftUI
import Combine

    // MARK: - Rounded Border Shape

    /// Shape personnalisée qui suit exactement le contour de l'écran avec des coins arrondis
struct RoundedBorderShape: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let radius = min(cornerRadius, min(width, height) / 2)
        
            // Commence en haut au centre
        path.move(to: CGPoint(x: width / 2, y: 0))
        
            // Ligne vers le coin haut-droit
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        
            // Arc coin haut-droit
        path.addArc(
            center: CGPoint(x: width - radius, y: radius),
            radius: radius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
            // Ligne vers le coin bas-droit
        path.addLine(to: CGPoint(x: width, y: height - radius))
        
            // Arc coin bas-droit
        path.addArc(
            center: CGPoint(x: width - radius, y: height - radius),
            radius: radius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
            // Ligne vers le coin bas-gauche
        path.addLine(to: CGPoint(x: radius, y: height))
        
            // Arc coin bas-gauche
        path.addArc(
            center: CGPoint(x: radius, y: height - radius),
            radius: radius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
            // Ligne vers le coin haut-gauche
        path.addLine(to: CGPoint(x: 0, y: radius))
        
            // Arc coin haut-gauche
        path.addArc(
            center: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        
            // Ligne de retour au point de départ
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        
        return path
    }
}

    // MARK: - Animated Border View

    /// Affiche une bordure personnalisée qui se remplit progressivement
struct AnimatedBorderView: View {
    let progress: Double
    let color: Color
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    let showBackground: Bool
    let inset: CGFloat
    
    init(
        progress: Double,
        color: Color = .red,
        cornerRadius: CGFloat = 47,
        lineWidth: CGFloat = 4,
        showBackground: Bool = true,
        inset: CGFloat = 8
    ) {
        self.progress = progress
        self.color = color
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.showBackground = showBackground
        self.inset = inset
    }
    
    var body: some View {
        ZStack {
                // Fond gris - RoundedBorderShape
            if showBackground {
                RoundedBorderShape(cornerRadius: cornerRadius)
                    .stroke(color.opacity(0.3), lineWidth: lineWidth)
                    .padding(inset)
            }
            
                // Bordure rouge animée avec progression - utilise la  même forme que RoundedBorderShape
            RoundedBorderShape(cornerRadius: cornerRadius)
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .padding(inset)
                .animation(.linear(duration: 1.0), value: progress)
        }
    }
}

    // MARK: - Progress Bar View

    /// Barre de progression horizontale avec pourcentage
struct ProgressBarView: View {
    let progress: Double
    let color: Color
    let width: CGFloat
    
    init(
        progress: Double,
        color: Color = .red,
        width: CGFloat = 300
    ) {
        self.progress = progress
        self.color = color
        self.width = width
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(Int(progress * 100))%")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(color.opacity(0.3))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(color)
                    .frame(width: width * progress)
                    .frame(height: 8)
            }
            .frame(width: width)
        }
    }
}

    // MARK: - Border Timer View

struct BorderTimerView: View {
        // ViewModel pour synchroniser avec le timer principal
    var viewModel: TimerViewModel
    
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    let inset: CGFloat
    
    init(
        viewModel: TimerViewModel,
        cornerRadius: CGFloat = 60,
        lineWidth: CGFloat = 6,
        inset: CGFloat = 1
    ) {
        self.viewModel = viewModel
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.inset = inset
    }
    
        /// Durée totale du cycle en cours (focus ou pause) - récupérée depuis viewModel
    private var currentCycleDuration: TimeInterval {
        viewModel.estEnPause
        ? TimeInterval(viewModel.pauseDuration)
        : TimeInterval(viewModel.concentrationDuration)
    }
    
        /// Calcule le progrès (0.0 à 1.0) basé sur le temps écoulé
    private var progress: Double {
        let totalDuration = currentCycleDuration
        let timeElapsed = totalDuration - TimeInterval(viewModel.timeRemaining)
        
            // Si aucun temps n'a été écoulé, on est au début
        if timeElapsed == 0 {
            return 0
        }
        
        let calculatedProgress = timeElapsed / totalDuration
        return max(0, min(1, calculatedProgress))
    }
    
        /// Couleur selon le type de cycle
    private var currentColor: Color {
        viewModel.estEnPause ? .green : .red
    }
    
    var body: some View {
        GeometryReader { geometry in
                // Bordure animée qui s'adapte à l'orientation
            AnimatedBorderView(
                progress: progress,
                color: currentColor,
                cornerRadius: cornerRadius,
                lineWidth: lineWidth,
                showBackground: true,
                inset: inset
            )
            .padding(.horizontal, calculatePadding(for: geometry.size))
        }
    }
    
        /// Calcule le padding selon la largeur de l'écran
    private func calculatePadding(for size: CGSize) -> CGFloat {
        let width = size.width
        let height = size.height
        
        if width > height {
            return 200
        } else {
            return 0
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        BorderTimerView(viewModel: TimerViewModel())
    }
}
