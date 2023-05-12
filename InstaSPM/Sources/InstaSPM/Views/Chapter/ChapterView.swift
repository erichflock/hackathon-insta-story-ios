import SwiftUI

struct ChapterView: View {
    
    @Binding private var isLongPressed: Bool
    var chapter: Chapter
    
    public init(isLongPressed: Binding<Bool>, chapter: Chapter) {
        self.chapter = chapter
        _isLongPressed = isLongPressed
    }
    
    var body: some View {
        ZStack {
            switch chapter.type {
                case .image:
                    AsyncImage(url: URL(string: chapter.url))
                case .video:
                    VideoView(isLongPressed: $isLongPressed, url: chapter.url)
                case .soundPic:
                    Text("What the hell!?")
            }
            Color.black
                .opacity(!isLongPressed ? 0.0 : 0.2)
        }
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
                                   type: .image))
    }
}
