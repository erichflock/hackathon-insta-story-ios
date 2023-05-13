//
//  SwiftUIView.swift
//  
//
//  Created by Erich Flock on 12.05.23.
//

import SwiftUI
import Combine

struct StoryBarView: View {
    
    var numberOfChapters: Int
    var currentIndex: Int
    @State var storyTimer: StoryTimer
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<numberOfChapters) { index in
                //ChapterBarView(progress: min(max((CGFloat(self.storyTimer.progress) - CGFloat(index)), 0.0), 1.0))
                ChapterBarView(progress: index == currentIndex ? 1 : 0)
                    .frame(width: nil, height: 2, alignment: .leading)
                    .animation(.linear)
            }
        }.padding()
    }
}

struct StoryBarView_Previews: PreviewProvider {
    static var previews: some View {
        StoryBarView(numberOfChapters: 0, currentIndex: 0, storyTimer: .init(items: 0, interval: 0))
    }
}

class StoryTimer: ObservableObject {
    
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    
    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
    
    func start() {
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: {  _ in
            var newProgress = self.progress + (0.1 / self.interval)
            if Int(newProgress) >= self.max { newProgress = 0 }
            self.progress = newProgress
        })
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    func advance(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % self.max , 0)
        self.progress = Double(newProgress)
    }
}
