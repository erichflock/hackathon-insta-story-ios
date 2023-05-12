import SwiftUI
import AVKit

struct VideoView: View {
    private let videoPlayer: AVPlayer?
    @State private var playing = true
    @Binding private var isLongPressed: Bool
    
    init(isLongPressed: Binding<Bool>, url: String) {
        if let url = URL(string: url) {
            self.videoPlayer = AVPlayer(url: url)
        } else {
            self.videoPlayer = nil
        }
        _isLongPressed = isLongPressed
    }
    
    var body: some View {
        if let videoPlayer {
            ZStack {
                PlayerViewController(player: videoPlayer)
            }.ignoresSafeArea(.all)
            .onChange(of: !isLongPressed) { play in
                if play {
                    videoPlayer.play()
                } else {
                    videoPlayer.pause()
                }
            }
        } else {
            Text("Url invalid")
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(
            isLongPressed: .constant(false),
            url: "https://dev.whost.ml/mixkit-pink-and-blue-ink-1192-medium.mp4")
    }
}
