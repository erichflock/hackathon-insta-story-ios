import SwiftUI

struct StoryView: View {
    
    var story: Story
    
    var body: some View {
        if isImage {
            AsyncImage(url: URL(string: story.url))
        } else {
            VideoView()
        }
    }
    
    var isImage: Bool {
        return false
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(story: .init(id: 0, url: "", length: 0, posted: 0, status: ""))
    }
}
