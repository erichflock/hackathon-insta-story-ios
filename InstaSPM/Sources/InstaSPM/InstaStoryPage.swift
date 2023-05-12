import SwiftUI

public struct InstaStoryPage: View {
    public init() {}
    
    @State private var isLoading = false
    @ObservedObject private var viewModel = InstaStoryPageViewModel()
    
    public var body: some View {
        ZStack {
            if let story = viewModel.getNextNewStory() {
                StoryView(story: story)
                    .onTapGesture {
                        viewModel.setStoryAsSeen(seenStory: story)
                    }
            }
        }
        .onAppear {
            fetchData(NetworkURLs.list10Pics)
        }
    }
    
    func fetchData(_ urlString: String) {
        isLoading = true
        Task {
            do {
                viewModel.stories = try await Network.fetchStories(urlString)
            } catch {
                print("Error: \(error)")
            }
            isLoading = false
        }
    }
}

struct InstaStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        InstaStoryPage()
    }
}
