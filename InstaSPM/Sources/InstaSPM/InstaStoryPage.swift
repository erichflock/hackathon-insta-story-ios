import SwiftUI

struct InstaStoryPage: View {
    init(viewModel: InstaStoryPageViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var isLoading = false
    @ObservedObject private var viewModel: InstaStoryPageViewModel
    @State private var isLongPressed = false
    
    var body: some View {
        ZStack(alignment: .top) {
            if let chapter = viewModel.getCurrentChapter() {
                ChapterView(isLongPressed: $isLongPressed, chapter: chapter)
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
//            .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    isLongPressed = true
//                }
//                .onEnded { value in
//                    isLongPressed = false
//                }
//            )
        }
    }
}

struct InstaStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        InstaStoryPage(viewModel: InstaStoryPageViewModel())
    }
}
