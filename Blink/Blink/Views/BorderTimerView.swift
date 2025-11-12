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
            
            // Bordure rouge animée avec progression - utilise la  MÊME forme que RoundedBorderShape
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
                .animation(.linear(duration: 0.1), value: progress)
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
                // Affichage du pourcentage
            Text("\(Int(progress * 100))%")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
            
                // Barre visuelle
            ZStack(alignment: .leading) {
                    // Fond de la barre
                RoundedRectangle(cornerRadius: 4)
                    .fill(color.opacity(0.3))
                    .frame(height: 8)
                
                    // Progression
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
    // Paramètres configurables (à lier avec les réglages utilisateur)
    let focusDuration: TimeInterval // Durée de concentration en secondes
    let pauseDuration: TimeInterval // Durée de pause en secondes
    
    @State private var currentSecond: Double = 0
    @State private var isPause: Bool = false // true = pause, false = focus
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init(
        focusDuration: TimeInterval = 25 * 60, // 25 minutes par défaut
        pauseDuration: TimeInterval = 5 * 60    // 5 minutes par défaut
    ) {
        self.focusDuration = focusDuration
        self.pauseDuration = pauseDuration
    }
    
    /// Durée totale du cycle en cours (focus ou pause)
    private var currentCycleDuration: TimeInterval {
        isPause ? pauseDuration : focusDuration
    }
    
    /// Calcule le progrès (0.0 à 1.0) en fonction du cycle actuel
    private var progress: Double {
        currentSecond / currentCycleDuration
    }
    
    /// Couleur selon le type de cycle
    private var currentColor: Color {
        isPause ? .green : .red
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Bordure animée personnalisée
                AnimatedBorderView(
                    progress: progress,
                    color: currentColor,
                    inset: 8
                )
                
                // Barre de progression temporaire (à enlever plus tard)
                ProgressBarView(
                    progress: progress,
                    color: currentColor,
                    width: geometry.size.width * 0.8
                )
            }
        }
        .ignoresSafeArea()
        .onReceive(timer) { _ in
            currentSecond += 0.1
            
            // Quand le cycle est terminé, bascule vers l'autre
            if currentSecond >= currentCycleDuration {
                currentSecond = 0
                isPause.toggle()
            }
        }
    }
}

    // MARK: - Preview

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        BorderTimerView()
    }
}
