import SwiftUI

struct ChapterView: View {
    
    @Binding private var isLongPressed: Bool
    var chapter: Chapter
    var numberOfChapters: Int
    var index: Int
    
    @ObservedObject var storyTimer: StoryTimer
    
    public init(isLongPressed: Binding<Bool>, chapter: Chapter, numberOfChapters: Int, index: Int, storyTimer: StoryTimer) {
        self.chapter = chapter
        _isLongPressed = isLongPressed
        self.numberOfChapters = numberOfChapters
        self.index = index
        self.storyTimer = storyTimer
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            switch chapter.type {
                case .image:
                    AsyncImage(url: URL(string: chapter.url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .ignoresSafeArea(.all)
                    } placeholder: {
                            Text("Loading...")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                    }
                       
                case .video:
                    VideoView(isLongPressed: $isLongPressed, url: chapter.url)
                case .soundPic:
                    Text("What the hell!?")
            }
            
            StoryBarView(numberOfChapters: numberOfChapters,
                         currentIndex: index,
                         storyTimer: storyTimer)
                .frame(width: UIScreen.main.bounds.width)
            
            Color.black
                .opacity(!isLongPressed ? 0.0 : 0.2)
        }.background(.black)
            .onAppear { storyTimer.start() }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(isLongPressed: .constant(false),
                    chapter: .init(id: 0,
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
