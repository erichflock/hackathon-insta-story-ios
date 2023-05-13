import SwiftUI

class InstaOverviewPageViewModel: ObservableObject {
    @Published var stories: [Story] = []
    private let imageLoader = RemoteImageLoader()
    
    func getIsStorySeen(story: Story) -> Bool {
        return story.chapters.first?.status == "SEEN"
    }
    
    @MainActor func loadPreviewAndFirstChapters(stories: [Story]) async {
        for story in stories {
            await imageLoader.load(urlString: story.preview)
        }
        
        self.stories = stories
        
        Task {
            for story in stories {
                await imageLoader.load(urlString: story.chapters.first?.url)
            }
        }
    }
}
