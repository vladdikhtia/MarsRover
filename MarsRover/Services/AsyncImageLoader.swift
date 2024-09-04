//
//  AsyncImageLoader.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import Foundation
import SwiftUI

class AsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cache = ImageCacheHelper.instance
    
    func loadImageAsyncAwait(from url: URL) {
        let urlString = url.absoluteString
        
        if let cachedImage = cache.getImage(key: urlString) {
            self.image = cachedImage
            return
        }
        
        Task{
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard data == data,
                      let loadedImage = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.cache.saveImage(image: loadedImage, key: urlString)
                    self.image = loadedImage
                }
            } catch  {
                print("Failed to loadImageAsyncAwait: \(error.localizedDescription)")
            }
        }
    }
}
