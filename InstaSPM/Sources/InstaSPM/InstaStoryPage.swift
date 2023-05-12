import SwiftUI

public struct InstaStoryPage: View {
    public init() {}
    
    @State private var isLoading = false
    @ObservedObject private var viewModel = InstaStoryPageViewModel()
    
    public var body: some View {
        ZStack(alignment: .top) {
            if let chapter = viewModel.getCurrentChapter() {
                ChapterView(chapter: chapter)
            }

            StoryBarView(chapters: viewModel.chapters)
                .frame(width: UIScreen.main.bounds.width)
            
            HStack(spacing: 0) {
                // It's there but not
                Rectangle().fill(Color.black)
                    .background(Color.black)
                    .opacity(0.0000000001)
                    .onTapGesture {
                        viewModel.getPreviousChapter()
                    }
                Rectangle().fill(Color.black)
                    .background(Color.black)
                    .opacity(0.0000000001)
                    .onTapGesture {
                        viewModel.getNextChapter()
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
                let stories = try await Network.fetchStories(urlString)
                viewModel.chapters = stories[1].chapters
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
