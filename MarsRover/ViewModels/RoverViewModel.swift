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
    @Published var currentRover: MarsRover = .curiosity
    @Published var currentDate: String = "2019-6-6" {
        didSet {
            if let newDate = DateFormatter.date(from: currentDate) {
                selectedDate = newDate
            }
        }
    }
    @Published var currentCamera: MarsCamera = .all
    @Published var currentPage: Int = 1
    
    @Published var selectedDate: Date = Date()
    
    let networkManager = NetworkManager.instance
    
    
    var formattedDateForDisplaying: String {
        return DateFormatter.string(from: selectedDate)
    }
    init() {
        fetchData()
    }
    
    // add subscriber
    func fetchData() {
        do {
            try networkManager.getData(rover: currentRover.path, date: currentDate, camera: currentCamera, page: currentPage)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
        
        print("Subscribing to networkManager.$returnedPhotos")
        
        networkManager.$returnedPhotos
            .sink { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
            }
            .store(in: &cancellable)
    }
    
    func upadateRover(newRover: MarsRover) {
        currentRover = newRover
        fetchData()
    }
    
    func updateDate(newDate: String) {
        currentDate = newDate
        fetchData()
    }
    func updateCamera(newCamera: MarsCamera) {
        currentCamera = newCamera
        fetchData()
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    static func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
