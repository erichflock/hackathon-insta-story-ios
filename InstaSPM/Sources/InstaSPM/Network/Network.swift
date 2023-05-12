import Foundation


struct NetworkURLs {
    static let list2Pics = "https://b13f05a4-376f-4dc0-962e-ca4b7bdc2af4.mock.pstmn.io/stories/list"
    static let list10Pics = "https://b13f05a4-376f-4dc0-962e-ca4b7bdc2af4.mock.pstmn.io/stories/list"
    static let listVideos = "https://b13f05a4-376f-4dc0-962e-ca4b7bdc2af4.mock.pstmn.io/stories/list"
}

struct Stories: Decodable {
    let stories: [Story]
}

struct Story: Decodable {
    
    let id: Int // 125
    let url: String // "https://wallpapers.com/images/featured-full/mobile-58g8gv3r23zg29kw.jpg",
    let length: Int // 50,
    let posted: Int // 1683885376,
//          let banners: [],
    var status: String // "SEEN"
}

class Network {
    public static func fetchStories(_ urlString: String) async throws -> [Story] {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw URLError(URLError.Code(rawValue: -1337))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let stories = try decoder.decode(Stories.self, from: data)
        print("Did Fetch \(stories.stories)")
        return stories.stories
    }
}
