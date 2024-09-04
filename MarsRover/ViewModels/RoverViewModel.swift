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
    @Published var currentCamera: MarsCamera = .all
    @Published var currentPage: Int = 1
    @Published var selectedDate: Date = Date()
    @Published var currentDate: String = "2019-6-6" {
        didSet {
            if let newDate = DateFormatter.date(from: currentDate) {
                selectedDate = newDate
            }
        }
    }
        
    let networkManager = NetworkManager.instance
        
    var formattedDateForDisplaying: String {
        return DateFormatter.string(from: selectedDate)
    }
    init() {
        self.selectedDate = DateFormatter.date(from: currentDate) ?? Date()
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
    
    // Trying to make pagination with async await
    /*
     func fetchData() {
     Task{
     do {
     self.photos = try await networkManager.getDataAsyncAwait(rover: currentRover.path, date: currentDate, camera: currentCamera, page: currentPage)
     } catch {
     print("Error occurred: \(error.localizedDescription)")
     }
     }
     
     }
     
     func loadMorePhotos() {
     currentPage += 1
     Task{
     do{
     let tempPhotos = try await networkManager.getDataAsyncAwait(rover: currentRover.path, date: currentDate, camera: currentCamera, page: currentPage)
     self.photos?.append(contentsOf: tempPhotos)
     print("Loaded new photos!")
     } catch {
     print("Error occurred during loading more data: \(error.localizedDescription)")
     }
     }
     }*/
    
    
    // Trying to make pagination with combine
    /*func loadMorePhotos() {
     guard !isLoading else {
     print("Loading")
     return
     }
     isLoading = true
     
     var tempPhotos: [Photo] = []
     currentPage += 1
     getDataFromApi()
     
     networkManager.$returnedPhotos
     .sink { [weak self] returnedPhotos in
     guard let self = self else { return }
     
     tempPhotos = returnedPhotos.filter { photo in
     !self.appPhotos.contains { $0.id == photo.id }
     }
     
     self.appPhotos.append(contentsOf: tempPhotos)
     self.isLoading = false
     print("Loaded more photos")
     }
     .store(in: &cancellable)
     }
     func fetchData() {
     fetchDataForTempPhotos()
     print("TempPhotos: \(tempPhotos)")
     self.appPhotos = tempPhotos
     print("AppPhotos: \(appPhotos)")
     
     }*/
}


