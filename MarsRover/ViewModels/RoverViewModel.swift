//
//  RoverViewModel.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import Foundation
import Combine

class RoverViewModel : ObservableObject {
    @Published var photos: [Photo] = []
    var cancellable = Set<AnyCancellable>()
    
    let networkManager = NetworkManager.instance
    
    init() {
        fetchData()
//        self.photos = example.photos
    }
    
    // add subscriber
    func fetchData() {
        print("Subscribing to networkManager.$returnedPhotos")

        networkManager.$returnedPhotos
            .sink { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
            }
            .store(in: &cancellable)
    }
    
    
}
