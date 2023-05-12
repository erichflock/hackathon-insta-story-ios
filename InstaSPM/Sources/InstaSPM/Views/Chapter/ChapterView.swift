import SwiftUI

struct ChapterView: View {
    
    var chapter: Chapter
    
    var body: some View {
        if isImage {
            AsyncImage(url: URL(string: chapter.url))
        } else {
            VideoView()
        }
    }
    
    var isImage: Bool {
        return true
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
                                   type: ""))
    }
}
