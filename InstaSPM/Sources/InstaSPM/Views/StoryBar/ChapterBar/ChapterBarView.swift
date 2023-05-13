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
                    .frame(width: geometry.size.width * calculateWidthFactor(), height: nil, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.9))
                    .cornerRadius(5)
            }
        }
    }
    
    func calculateWidthFactor() -> CGFloat {
        progress > 1 ? 1 : progress
    }
}

struct ChapterBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterBarView(progress: 0)
    }
}
