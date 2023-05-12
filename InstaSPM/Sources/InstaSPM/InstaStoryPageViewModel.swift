import SwiftUI

class InstaStoryPageViewModel: ObservableObject {
    
    @Published var stories: [Story] = []
    
    func getNextNewStory() -> Story? {
        stories.first(where: { $0.status == "NEW" } )
    }
    
    func setStoryAsSeen(seenStory: Story?) {
        guard let seenStory else { return }
        
        for (index, story) in self.stories.enumerated() {
            if story.id == seenStory.id {
                self.stories[index].status = "SEEN"
            }
        }
    }
}
