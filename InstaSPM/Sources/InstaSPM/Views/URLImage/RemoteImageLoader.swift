import SwiftUI
import Combine

public class RemoteImageLoader: ObservableObject {
    
    @Published public private(set) var image: UIImage?
    
    private var task: Task<(), Never>?
    
    public init() {}
    
    public func load(urlString: String?) {
        // If an image is cached it must be set immediately. Doing so asynchronously inside the
        // `Task` would leave self.image `nil` for a short while even when a cached image is present.
        // This can cause issues, such as flickering in the UI when no image is displayed before
        // the cached image appears.
        if let cachedImage = getCachedImage(for: urlString) {
            image = cachedImage
        } else {
            Task {
                await load(urlString: urlString)
            }
        }
    }
    
    @MainActor
    public func load(urlString: String?) async {
        task?.cancel()
        
        #if DEBUG
        let isRunningInTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        let isRunningInPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        if isRunningInTests || isRunningInPreview {
            return
        }
        #endif
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = getCachedImage(for: urlString) {
            image = cachedImage
            return
        }
        
        task = Task {
            let result = try? await URLSession.shared.data(from: url)
            if let result, let imageResult = UIImage(data: result.0) {
                ImageCache.cacheImage(image: imageResult, withKey: urlString)
                image = imageResult
            }
        }
        await task?.value
    }
    
    private func getCachedImage(for urlString: String?) -> UIImage? {
        guard let urlString = urlString else {
            return nil
        }
        
        if let image = ImageCache.getImage(withKey: urlString) {
            return image
        }
        
        return nil
    }
    
    public func loadAndCacheImageAsync(urlString: String) async throws -> Bool {
        if let _ = ImageCache.getImage(withKey: urlString) {
            return true
        }
        
        guard let url = URL(string: urlString) else {
            return false
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // 10 seconds
        
        let (data, response) = try await URLSession(configuration: configuration).data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let image = UIImage(data: data) else {
            return false
        }
        
        ImageCache.cacheImage(image: image, withKey: urlString)
        return true
    }
}

class ImageCache {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(image: UIImage, withKey: String) {
        imageCache.setObject(image, forKey: withKey as AnyObject)
    }
    
    static func getImage(withKey: String) -> UIImage? {
        guard let imageFromCache = imageCache.object(forKey: withKey as AnyObject) as? UIImage else { return nil }
        return imageFromCache
    }
}

