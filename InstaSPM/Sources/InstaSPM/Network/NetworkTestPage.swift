import Foundation
import SwiftUI

public struct NetworkTestPage: View {
    public init() {
    }
    @State private var isLoading = false
    @State private var stories: [Story]?
    
    public var body: some View {
        VStack {
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
            }
            if isLoading {
                ProgressView()
            } else {
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
            }
            if isLoading {
                ProgressView()
            } else {
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
            isLoading = false
        }
    }
}
