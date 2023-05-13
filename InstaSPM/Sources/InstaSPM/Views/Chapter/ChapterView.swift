import SwiftUI

struct ChapterView: View {
    
    var chapter: Chapter
    var numberOfChapters: Int
    var index: Int
    
    @ObservedObject var storyTimer: StoryTimer
    
    var body: some View {
        ZStack(alignment: .top) {
            switch chapter.type {
                case .image:
                    AsyncImage(url: URL(string: chapter.url))
                    .frame(height: .zero)
                case .video:
                    VideoView(url: chapter.url)
                case .soundPic:
                    Text("What the hell!?")
            }
            
            StoryBarView(numberOfChapters: numberOfChapters,
                         currentIndex: index,
                         storyTimer: storyTimer)
                .frame(width: UIScreen.main.bounds.width)
        }
        .onAppear { storyTimer.start() }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(chapter: .init(id: 0,
                                   url: "",
                                   length: 1,
                                   posted: 1,
                                   status: "",
                                   startAt: 0,
                                   endAt: 0,
                                   type: .image),
                    numberOfChapters: 0,
                    index: 0,
                    storyTimer: .init(items: 0, interval: 0))
    }
}
