//
//  SwiftUIView.swift
//  
//
//  Created by Erich Flock on 12.05.23.
//

import SwiftUI

struct StoryView: View {
    
    var story: Story
    
    var body: some View {
        AsyncImage(url: URL(string: story.url))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(story: .init(id: 0, url: "", length: 0, posted: 0, status: ""))
    }
}
