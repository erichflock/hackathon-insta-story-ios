import SwiftUI

class InstaOverviewPageViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    func getIsStorySeen(story: Story) -> Bool {
        return story.chapters.first?.status == "SEEN"
    }
}
