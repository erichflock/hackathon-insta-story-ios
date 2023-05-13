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
        VStack(alignment: .center) {
            if let image = imageLoader.image {
                AnyView(imageTransformation(Image(uiImage: image)))
            } else if placeholder {
                Spacer()
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                    .padding(8)
                Spacer()
            }
        }.background(.black)
    }
}
