//
//  SwiftUIView.swift
//  
//
//  Created by Erich Flock on 12.05.23.
//

import SwiftUI

struct StoryBarView: View {
    
    var chapters: [Chapter]
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(chapters) { chapter in
                ChapterBarView(progress: 1)
                    .frame(width: nil, height: 2, alignment: .leading)
                    .animation(.linear)
            }
        }.padding()
    }
}

struct StoryBarView_Previews: PreviewProvider {
    static var previews: some View {
        StoryBarView(chapters: [])
    }
}
