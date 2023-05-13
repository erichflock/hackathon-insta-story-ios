//
//  SwiftUIView.swift
//  
//
//  Created by Erich Flock on 12.05.23.
//

import SwiftUI

struct ChapterBarView: View {
    
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)

                Rectangle()
                    .frame(width: geometry.size.width * self.progress, height: nil, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.9))
                    .cornerRadius(5)
            }
        }
    }
}

struct ChapterBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterBarView(progress: 0)
    }
}
