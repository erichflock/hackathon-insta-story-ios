import SwiftUI
import AVKit

struct VideoView: View {
    @ObservedObject var videoPlayer: VideoPlayer = VideoPlayer(url: "https://dev.whost.ml/mixkit-pink-and-blue-ink-1192-medium.mp4")
    @State private var playing = true
    @GestureState var press = false
    
    var body: some View {
        ZStack {
            PlayerViewController(videoPlayer: videoPlayer)
            
            Color.black
                .opacity(playing ? 0.0 : 0.2)
        }
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
        }.onChange(of: videoPlayer.currentTime) { newValue in
            print("Time: \(String(describing: newValue))")
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
