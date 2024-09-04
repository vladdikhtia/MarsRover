//
//  NetworkManager.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import Foundation
import Combine

class NetworkManager {
    @Published var returnedPhotos: [Photo] = []
    var cancellables = Set<AnyCancellable>()
    var isLoading: Bool = false
    
    static let instance = NetworkManager()
    private init(){}
    
    private let apiKey: String = "rlXu2zzTUOLFHRWP9RtLE73eqmwPrhzj8RKmeyBa"
    
    private func createURLComponents(rover: String, date: String, camera: MarsCamera, page: Int) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nasa.gov"
        urlComponents.path = "/mars-photos/api/v1/rovers/\(rover)/photos"
        
        var queryItems = [
            URLQueryItem(name: "earth_date", value: date),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        if camera != .all {
            queryItems.append(URLQueryItem(name: "camera", value: camera.rawValue))
        }
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    func getData(rover: String, date: String, camera: MarsCamera, page: Int) throws {
        self.isLoading = true
        print("IsLoading in the begining of getData: \(isLoading)")
        guard let url = createURLComponents(rover: rover, date: date, camera: camera, page: page).url else {
            print("DEBUG: Bad URL")
            self.isLoading = false
            throw URLError(.badURL)
        }
        print("IsLoading in the middle of getData: \(isLoading)")
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background)) //dataTaskPublisher automatically do it on background
            .receive(on: DispatchQueue.main)
            .tryMap (validatingOutput)
            .decode(type: PhotoResponseModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .finished:
                    print("Succeded")
                case .failure(let error):
                    print("Error during downloading! \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] receivedData in
                print("Raw JSON Data: \(receivedData.photos.count)")
                self?.returnedPhotos = receivedData.photos
                self?.isLoading = false
                print("IsLoading in the completion of getData: \(String(describing: self?.isLoading))")
            }
            .store(in: &cancellables)
    }
    
    private func validatingOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.fileDoesNotExist)
        }
        return output.data
    }
}
    // implemented getDataAsyncAwait for pagination...
    /*
    func getDataAsyncAwait(rover: String, date: String, camera: MarsCamera, page: Int) async throws -> [Photo] {
        guard let url = createURLComponents(rover: rover, date: date, camera: camera, page: page).url else {
            print("DEBUG: Bad URL")
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.dataNotAllowed)
            }
            guard !data.isEmpty else {
                throw URLError(.fileDoesNotExist)
            }
            do {
                let photoResponse = try JSONDecoder().decode(PhotoResponseModel.self, from: data)
                return photoResponse.photos
            } catch {
                print("DEBUG: Decoding error occurred: \(error.localizedDescription)")
                throw error
            }
        } catch {
            print("Failed to get data with async await: \(error)")
            throw error
        }
    }
    */
