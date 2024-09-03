//
//  ImageCacheHelper.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import Foundation
import SwiftUI

class ImageCacheHelper {
    static let instance = ImageCacheHelper()
    
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func saveImage(image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
