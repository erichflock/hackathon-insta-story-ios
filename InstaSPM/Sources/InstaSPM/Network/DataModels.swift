import Foundation

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
