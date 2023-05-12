import SwiftUI

public struct InstaStoryPage: View {
    public init() {}
    
    @State private var isLoading = false
    @ObservedObject private var viewModel = InstaStoryPageViewModel()
    @State private var isLongPressed = false
    
    public var body: some View {
        ZStack(alignment: .top) {
            if let chapter = viewModel.getCurrentChapter() {
                ChapterView(isLongPressed: $isLongPressed, chapter: chapter)
            }

            StoryBarView(chapters: viewModel.chapters)
            
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
            .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    isLongPressed = true
                    print("LongPressGesture tap")
                }
                .onEnded { value in
                    isLongPressed = false
                    print("LongPressGesture release")
                }
            )
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
