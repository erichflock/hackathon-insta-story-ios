import SwiftUI

class InstaStoryPageViewModel: ObservableObject {
    
    @Published var chapters: [Chapter] = []
    private var currentChapterIndex: Int = 0
    
    func getNextChapter() -> Chapter? {
        guard currentChapterIndex != chapters.count else {
            return nil
        }
        currentChapterIndex += 1
        return getChapterAtIndex(index: currentChapterIndex)
    }
    
    func getPreviousChapter() -> Chapter? {
        guard currentChapterIndex != 0 else {
            return nil
        }
        currentChapterIndex -= 1
        return getChapterAtIndex(index: currentChapterIndex)
    }
    
    func getCurrentChapter() -> Chapter? {
        getChapterAtIndex(index: currentChapterIndex)
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
