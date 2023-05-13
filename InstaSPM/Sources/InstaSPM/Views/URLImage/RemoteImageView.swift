import SwiftUI

public struct RemoteImageView: View {
    @ObservedObject private var imageLoader = RemoteImageLoader()
    private let placeholder: WrappedImage?
    private let imageTransformation: (Image, Bool) -> any View
    
    public init(
        withPath path: String?,
        placeholder: WrappedImage? = nil,
        @ViewBuilder imageTransformation: @escaping (Image, Bool) -> any View
    ) {
        self.placeholder = placeholder
        self.imageTransformation = imageTransformation
        
        imageLoader.load(urlString: path)
    }
    
    public init(
        withPath path: String?,
        placeholder: WrappedImage? = nil,
        imageTransformation: WrapperImageViewImageTransformation
    ) {
        self.init(
            withPath: path,
            placeholder: placeholder,
            imageTransformation: { image, _ in imageTransformation.closure(image) }
        )
    }
    
    public init(
        withURL url: URL?,
        placeholder: WrappedImage? = nil,
        @ViewBuilder imageTransformation: @escaping (Image, Bool) -> any View
    ) {
        self.init(
            withPath: url?.absoluteString,
            placeholder: placeholder,
            imageTransformation: imageTransformation
        )
    }
    
    public init(
        withURL url: URL?,
        placeholder: WrappedImage? = nil,
        imageTransformation: WrapperImageViewImageTransformation
    ) {
        self.init(
            withURL: url,
            placeholder: placeholder,
            imageTransformation: { image, _ in imageTransformation.closure(image) }
        )
    }
    
    public var body: some View {
        WrapperImageView(currentImage()) { image in
            imageTransformation(image, isCurrentImagePlaceholder())
        }
    }
    
    private func currentImage() -> WrappedImage {
        if let image = imageLoader.image {
            return .uiImage(image)
        } else if let placeholder {
            return placeholder
        } else {
            return .none
        }
    }
    
    private func isCurrentImagePlaceholder() -> Bool {
        return imageLoader.image == nil
    }
}
