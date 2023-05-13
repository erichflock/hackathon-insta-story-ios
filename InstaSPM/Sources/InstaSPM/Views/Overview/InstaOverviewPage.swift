import SwiftUI

public struct InstaOverviewPage: View {
    @ObservedObject private var viewModel: InstaOverviewPageViewModel = InstaOverviewPageViewModel()
    @State private var showChapter: Bool = false
    @State private var currentStory: Int = 0
    
    public init() {
    }
    
    public var body: some View {
        ZStack {
            if showChapter {
                // show InstaStoryPage
                ZStack(alignment: .top) {
                    TabView(selection: $currentStory) {
                        ForEach(viewModel.stories, id: \.id) { story in
                            InstaStoryPage(viewModel: InstaStoryPageViewModel(chapters: story.chapters))
                                .tag(story.id)
                        }
                    }.tabViewStyle(.page)
                        .ignoresSafeArea(.all)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            .padding(.top, 24)
                            .padding(.trailing, 16)
                            .onTapGesture {
                                withAnimation {
                                    showChapter = false
                                }
                            }
                    }.frame(width: UIScreen.main.bounds.width)
                }
            } else {
                // show overview
                overview
            }
        }.onAppear {
            if viewModel.stories.isEmpty {
                fetchData(NetworkURLs.list10Pics)
            }
        }
    }
    
    private var overview: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .zero) {
                ForEach(viewModel.stories, id: \.id) { story in
                    VStack(alignment: .center, spacing: 4) {
                        RemoteImageView(
                            withURL: URL(string: story.preview),
                            placeholder: false
                        ){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }.frame(width: 150, height: 150)
                            .background(.black)
                        .clipShape(Circle())
                            .padding(4)
                            .overlay(
                                 Circle()
                                     .stroke(viewModel.getIsStorySeen(story: story) ? .black : .red, lineWidth: 4)
                            )
                        
                        Text(story.title)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }.frame(width: 158)
                    .padding(8)
                    .onTapGesture {
                        currentStory = story.id
                        withAnimation {
                            showChapter = true
                        }
                    }
                }
            }
        }
    }
    
    func fetchData(_ urlString: String) {
        Task {
            do {
                let stories = try await Network.fetchStories(urlString)
                viewModel.stories = stories
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        InstaOverviewPage()
    }
}
