import SwiftUI

struct ChapterView: View {
    
    @Binding private var isLongPressed: Bool
    var chapter: Chapter
    var numberOfChapters: Int
    var index: Int
    
    public init(isLongPressed: Binding<Bool>, chapter: Chapter, numberOfChapters: Int, index: Int) {
        self.chapter = chapter
        _isLongPressed = isLongPressed
        self.numberOfChapters = numberOfChapters
        self.index = index
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            switch chapter.type {
                case .image:
                    RemoteImageView(
                        withURL: URL(string: chapter.url),
                        placeholder: .image(Image(systemName: "star"))
                    ){ image, isPlaceholder in
                        if isPlaceholder {
                            Color.black
                        } else {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                
                        }
                    }.ignoresSafeArea(.all)
                       
                case .video:
                    VideoView(isLongPressed: $isLongPressed, url: chapter.url)
                case .soundPic:
                    Text("What the hell!?")
            }
            
            StoryBarView(numberOfChapters: numberOfChapters,
                         currentIndex: index,
                         length: chapter.length)
                .frame(width: UIScreen.main.bounds.width)
            
            Color.black
                .opacity(!isLongPressed ? 0.0 : 0.1)
        }.background(.black)
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
                    index: 0)
    }
}
