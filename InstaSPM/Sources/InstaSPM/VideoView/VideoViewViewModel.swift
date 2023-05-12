import Foundation
import AVKit
import SwiftUI

class VideoPlayer: ObservableObject {
    let player: AVPlayer
    let url: String
    var timeObserverToken: Any?
    
    @Published var duration: Float64?
    @Published var currentTime: Float64?
    
    init(url: String) {
        self.url = url
        self.player = AVPlayer(url: URL(string: url)!)
        self.currentTime = CMTimeGetSeconds(player.currentTime())

        addPeriodicTimeObserver()
    }
    
    deinit {
        removePeriodicTimeObserver()
    }
    
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.1, preferredTimescale: timeScale)

        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            guard let self else { return }
    
            self.currentTime = CMTimeGetSeconds(time)
            
            if self.duration == nil, let currentItem = self.player.currentItem {
                self.duration = CMTimeGetSeconds(currentItem.duration)
            }
        }
    }

    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}

struct PlayerViewController: UIViewControllerRepresentable {
    var videoPlayer: VideoPlayer

    private var player: AVPlayer {
        return videoPlayer.player
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.showsPlaybackControls = false
        controller.player = player
        controller.player?.play()
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
    
    
}
