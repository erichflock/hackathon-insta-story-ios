import Foundation
import AVKit
import SwiftUI

struct PlayerViewController: UIViewControllerRepresentable {
    
    var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerVC = AVPlayerViewController()
        playerVC.modalPresentationStyle = .overFullScreen
        playerVC.showsPlaybackControls = false
        playerVC.videoGravity = .resizeAspectFill
        playerVC.player = player
        playerVC.player?.play()
        
        return playerVC
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.player = player
        playerController.player?.play()
    }
}
