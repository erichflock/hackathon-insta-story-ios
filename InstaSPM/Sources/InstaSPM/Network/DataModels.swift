import Foundation

struct Stories: Decodable {
    let stories: [Story]
}

struct Story: Decodable {
    let chapters: [Chapter]
    let title: String
    let preview: String
    let id: Int
}

enum MediaType: String, Decodable {
    case image = "IMAGE"
    case video = "VIDEO"
    case soundPic = "SOUND_PIC"
}

struct Chapter: Decodable, Identifiable {
    let id: Int // 125
    let url: String // "https://wallpapers.com/images/featured-full/mobile-58g8gv3r23zg29kw.jpg",
    let length: Int // 50,
    let posted: Int // 1683885376,
//          let banners: [],
    let status: String // "SEEN"
    let startAt: Int?
    let endAt: Int?
    let type: MediaType
}
