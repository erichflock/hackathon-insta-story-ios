import SwiftUI

public struct InstaStoryPage: View {
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct InstaStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        InstaStoryPage()
    }
}
