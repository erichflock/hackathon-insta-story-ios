import SwiftUI
import Combine

struct StoryBarView: View {
    
    var numberOfChapters: Int
    var currentIndex: Int
    
    @State private var progress = 0.0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<numberOfChapters) { index in
                let progress: CGFloat = index < currentIndex ? 1 : index == currentIndex ? progress : 0
                ChapterBarView(progress: progress)
                    .frame(width: nil, height: 2, alignment: .leading)
                    .animation(.linear)
                    .onReceive(timer) { _ in
                        updateProgess()
                    }
            }
        }.padding()
    }
    
    func updateProgess() {
        guard progress < 1 else { return }
        progress += 0.2
    }
}

struct StoryBarView_Previews: PreviewProvider {
    static var previews: some View {
        StoryBarView(numberOfChapters: 0, currentIndex: 0)
    }
}
