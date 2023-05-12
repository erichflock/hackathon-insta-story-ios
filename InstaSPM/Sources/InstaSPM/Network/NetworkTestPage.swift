import Foundation
import SwiftUI

public struct NetworkTestPage: View {
    public init() {
    }
    @State private var isLoading = false
    @State private var stories: [Story]?
    @State private var showContent = false
    
    private var hasContent: Bool {
        if let stories = stories, stories.count > 0 {
            return true
        }
        return false
    }
    
    var shouldShowContent: Bool {
        return hasContent && showContent
    }
    
    public var body: some View {
        VStack {
            if showContent {
                
                Text(stories?.description ?? "No Data")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            self.showContent = true
                        }
                    }
                Button(action: {
                    fetchData(NetworkURLs.list2Pics)
                }, label: {
                    Text("Reload")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
                Button(action: {
                    withAnimation {
                        self.showContent = false
                    }
                }, label: {
                    Text("Back")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
            } else {
                
                if isLoading {
                    ProgressView()
                } else {
                    Button(action: {
                        fetchData(NetworkURLs.list2Pics)
                    }, label: {
                        Text("Fetch 2 Pics")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .padding()
                    Button(action: {
                        fetchData(NetworkURLs.list10Pics)
                    }, label: {
                        Text("Fetch 10 Pics")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .padding()
                    Button(action: {
                        fetchData(NetworkURLs.listVideos)
                    }, label: {
                        Text("Fetch Videos")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .padding()
                }
            }
        }
        .padding()
    }
    
    func fetchData(_ urlString: String) {
        isLoading = true
        Task {
            do {
                stories = try await Network.fetchStories(urlString)
            } catch {
                print("Error: \(error)")
            }
            withAnimation {
                isLoading = false
                showContent = true
            }
        }
    }
}
