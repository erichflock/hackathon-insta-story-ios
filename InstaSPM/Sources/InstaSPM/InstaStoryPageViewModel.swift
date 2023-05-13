import SwiftUI

class InstaStoryPageViewModel: ObservableObject {
    
    @Published var chapters: [Chapter] = []
    @Published var currentChapterIndex: Int = 0
    private let imageLoader = RemoteImageLoader()
    
    init(chapters: [Chapter] = [], currentChapterIndex: Int = 0) {
        self.chapters = chapters
        self.currentChapterIndex = currentChapterIndex
    }
    
    @discardableResult
    func getNextChapter() -> Chapter? {
        guard currentChapterIndex < chapters.count-1 else {
            return nil
        }
        currentChapterIndex += 1
        return getChapterAtIndex(index: currentChapterIndex)
    }
    
    @discardableResult
    func getPreviousChapter() -> Chapter? {
        guard currentChapterIndex != 0 else {
            return nil
        }
        currentChapterIndex -= 1
        return getChapterAtIndex(index: currentChapterIndex)
    }
    
    func getCurrentChapter() -> Chapter? {
        let chapter = getChapterAtIndex(index: currentChapterIndex)
        
        Task {
            if let nextChapter = getChapterAtIndex(index: currentChapterIndex + 1) {
                _ = try? await imageLoader.loadAndCacheImageAsync(urlString: nextChapter.url)
            }
        }
        
        return chapter
    }
    
    func getChapterAtIndex(index: Int) -> Chapter? {
        if index >= 0 && index < chapters.count {
            return chapters[index]
        }
        return nil
    }

//    func setChapterAsSeen(seenChapter: Chapter?) {
//        guard let seenChapter else { return }
//
//        for (index, chapter) in self.chapters.enumerated() {
//            if chapter.id == chapter.id {
//                self.chapters[index].status = "SEEN"
//            }
//        }
//    }
}
