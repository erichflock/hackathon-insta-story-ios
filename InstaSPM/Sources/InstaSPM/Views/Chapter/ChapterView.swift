import SwiftUI

struct ChapterView: View {
    
    var chapter: Chapter
    
    var body: some View {
        switch chapter.type {
            case .image:
                AsyncImage(url: URL(string: chapter.url))
            case .video:
                VideoView(url: chapter.url)
            case .soundPic:
                Text("What the hell!?")
        }
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
                                   type: .image))
    }
}
