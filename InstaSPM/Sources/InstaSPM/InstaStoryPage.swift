import SwiftUI

public struct InstaStoryPage: View {
    public init() {
    }
    @State private var isLoading = false
    @State private var stories: [Story]?
    
    public var body: some View {
        ZStack {
            if let story = stories?.first {
                StoryView(story: story)
            }
        }
        .onAppear {
            fetchData(NetworkURLs.list2Pics)
        }
    }
    
    func fetchData(_ urlString: String) {
        isLoading = true
        Task {
            do {
                stories = try await Network.fetchStories(urlString)
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
