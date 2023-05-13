import SwiftUI

public struct RemoteImageView: View {
    @ObservedObject private var imageLoader = RemoteImageLoader()
    private let placeholder: Bool
    private let imageTransformation: (Image) -> any View
    
    public init(
        withPath path: String?,
        placeholder: Bool = false,
        @ViewBuilder imageTransformation: @escaping (Image) -> any View
    ) {
        self.placeholder = placeholder
        self.imageTransformation = imageTransformation
        
        imageLoader.load(urlString: path)
    }
    
    public init(
        withURL url: URL?,
        placeholder: Bool = false,
        @ViewBuilder imageTransformation: @escaping (Image) -> any View
    ) {
        self.init(
            withPath: url?.absoluteString,
            placeholder: placeholder,
            imageTransformation: imageTransformation
        )
    }
    
    public var body: some View {
        VStack {
            if let image = imageLoader.image, false {
                AnyView(imageTransformation(Image(uiImage: image)))
            } else if placeholder {
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }.background(.blue)
    }
}
