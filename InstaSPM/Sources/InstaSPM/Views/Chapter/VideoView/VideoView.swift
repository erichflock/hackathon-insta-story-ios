import SwiftUI
import AVKit

struct VideoView: View {
    private let videoPlayer: AVPlayer?
    @State private var playing = true
    @GestureState var press = false
    
    init(url: String) {
        if let url = URL(string: url) {
            self.videoPlayer = AVPlayer(url: url)
        } else {
            self.videoPlayer = nil
        }
    }
    
    var body: some View {
        if let videoPlayer {
            ZStack {
                PlayerViewController(player: videoPlayer)
                
                Color.black
                    .opacity(playing ? 0.0 : 0.2)
            }.ignoresSafeArea(.all)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        playing = false
                    }
                    .onEnded { value in
                        playing = true
                    }
                )
            .onChange(of: playing) { play in
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
        VideoView(url: "https://dev.whost.ml/mixkit-pink-and-blue-ink-1192-medium.mp4")
    }
}
