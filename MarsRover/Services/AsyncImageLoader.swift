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
    
    func loadImage(from url: URL) {
        let urlString = url.absoluteString
        
        if let cachedImage = cache.getImage(key: urlString) {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.cache.saveImage(image: loadedImage, key: urlString)
                self?.image = loadedImage
            }
        }
        task.resume()
    }
}
