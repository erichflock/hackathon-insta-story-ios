import SwiftUI

public enum WrappedImage: Equatable {
    case uiImage(_ uiImage: UIImage?)
    case image(_ image: Image?)
    case none
}

public struct WrapperImageView: View {
    
    private let wrappedImage: WrappedImage
    private let imageTransformation: (Image) -> any View
    
    public init(
        _ wrappedImage: WrappedImage,
        @ViewBuilder imageTransformation: @escaping (Image) -> any View
    ) {
        self.wrappedImage = wrappedImage
        self.imageTransformation = imageTransformation
    }
    
    /// Initialize a WrapperImageView with an image and a default image transformation
    public init(
        _ wrappedImage: WrappedImage,
        imageTransformation: WrapperImageViewImageTransformation
    ) {
        self.init(wrappedImage, imageTransformation: imageTransformation.closure)
    }
    
    public init(_ wrappedImage: WrappedImage) {
        self.init(wrappedImage, imageTransformation: { $0 })
    }
    
    public init(
        _ image: Image,
        @ViewBuilder imageTransformation: @escaping (Image) -> any View
    ) {
        self.init(.image(image), imageTransformation: imageTransformation)
    }
    
    public init(
        _ image: Image,
        imageTransformation: WrapperImageViewImageTransformation
    ) {
        self.init(image, imageTransformation: imageTransformation.closure)
    }
    
    public init(_ image: Image) {
        self.init(image, imageTransformation: { $0 })
    }
    
    public init(
        _ uiImage: UIImage,
        @ViewBuilder imageTransformation: @escaping (Image) -> any View
    ) {
        self.init(.uiImage(uiImage), imageTransformation: imageTransformation)
    }
    
    public init(
        _ uiImage: UIImage,
        imageTransformation: WrapperImageViewImageTransformation
    ) {
        self.init(uiImage, imageTransformation: imageTransformation.closure)
    }
    
    public init(_ uiImage: UIImage) {
        self.init(uiImage, imageTransformation: { $0 })
    }
    
    public var body: some View {
        switch wrappedImage {
            case .uiImage(.some(let image)):
                AnyView(imageTransformation(Image(uiImage: image)))
            case .image(.some(let image)):
                AnyView(imageTransformation(image))
            case .none, .uiImage(.none), .image(.none):
                // Do not use EmptyView, Group etc. as these views represent the
                // abscence of content, and therefore do not react to modifiers like .frame()
                VStack(spacing: 0) {}
                
        }
    }
}

// MARK: - WrapperImageViewImageTransformation
// Helper to allow us to have a convenient initializer for WrapperImageView where we can apply often-used transformations using a short syntax, e.g.:
// `WrapperImageView(myImage, imageTransformation: .fit)`
public struct WrapperImageViewImageTransformation {
    
    public static let fit = WrapperImageViewImageTransformation({
        $0
            .resizable()
            .aspectRatio(contentMode: .fit)
    })
    
    public static let fitWithOriginalRendering = WrapperImageViewImageTransformation({
        $0
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
    })
    
    let closure: (Image) -> any View
    
    private init(_ closure: @escaping (Image) -> any View) {
        self.closure = closure
    }

}
