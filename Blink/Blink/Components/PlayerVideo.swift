//
//  PlayerVideo.swift
//  Blink
//
//  Created by Arnaud on 13/11/2025.
//

import SwiftUI
import AVKit

struct LoopingPlayerView: UIViewRepresentable {
    var videoName: String
    var videoType: String
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero, videoName: videoName, videoType: videoType)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        (uiView as? PlayerUIView)?.player.pause()
    }
}

class PlayerUIView: UIView {
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    init(frame: CGRect, videoName: String, videoType: String) {
        super.init(frame: frame)
        guard let url = Bundle.main.url(forResource: videoName, withExtension: videoType) else {
            return
        }
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main ) {[weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
        player.play()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    
}
