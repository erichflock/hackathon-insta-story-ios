import SwiftUI

class InstaStoryPageViewModel: ObservableObject {
    
    @Published var stories: [Story] = []
    
    func getNextNewStory() -> Story? {
        let story = stories.first(where: { $0.status == "NEW" } )
        setStoryAsSeen(seenStory: story)
        return story
    }
    
    private func setStoryAsSeen(seenStory: Story?) {
        guard let seenStory else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for (index, story) in self.stories.enumerated() {
                if story.id == seenStory.id {
                    self.stories[index].status = "SEEN"
                }
            }
        }
    }
}
