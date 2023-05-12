import Foundation
import AVKit
import SwiftUI

struct PlayerViewController: UIViewControllerRepresentable {
    var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        controller.player = player
        controller.player?.play()
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}
