import SwiftUI

class InstaOverviewPageViewModel: ObservableObject {
    @Published var stories: [Story] = []
    private let imageLoader = RemoteImageLoader()
    
    func getIsStorySeen(story: Story) -> Bool {
        return story.chapters.first?.status == "SEEN"
    }
    
    func setStoriesAndLoadFirstChapters(stories: [Story]) async {
        for story in stories {
            await imageLoader.load(urlString: story.chapters.first?.url)
        }
        self.stories = stories
    }
}
