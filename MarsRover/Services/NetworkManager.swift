//
//  NetworkManager.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import Foundation
import Combine
//use this for camera: https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&camera=fhaz&&api_key=DEMO_KEY
// camera with pagination: https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&camera=fhaz&page=1&api_key=DEMO_KEY

// http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG
// http://mars.nasa.gov/mer/gallery/all/1/p/4037/1P486568465EFFCNJDP2407L2M1-BR.JPG

class NetworkManager {
    @Published var returnedPhotos: [Photo] = []
    var cancellables = Set<AnyCancellable>()
    
    static let instance = NetworkManager() // singleton
    
    private init(){
    }
    
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
        guard let url = createURLComponents(rover: rover, date: date, camera: camera, page: page).url else {
            print("DEBUG: Bad URL")
            throw URLError(.badURL)
        }
        
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
                print("Raw JSON Data: \(receivedData.photos)")
                self?.returnedPhotos = receivedData.photos
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

enum MarsRover: String, CaseIterable {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
    
    var path: String {
        return self.rawValue.lowercased()
    }
}

enum MarsCamera: String, CaseIterable {
    case all = "ALL"
    case fhaz = "FHAZ"
    case rhaz = "RHAZ"
    case mast = "MAST"
    case chemcam = "CHEMCAM"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case navcam = "NAVCAM"
    case pancam = "PANCAM"
    case minites = "MINITES"
    
    var description: String {
        switch self {
        case .all:
            return "All Cameras"
        case .fhaz:
            return "Front Hazard Avoidance Camera"
        case .rhaz:
            return "Rear Hazard Avoidance Camera"
        case .mast:
            return "Mast Camera"
        case .chemcam:
            return "Chemistry and Camera Complex"
        case .mahli:
            return "Mars Hand Lens Imager"
        case .mardi:
            return "Mars Descent Imager"
        case .navcam:
            return "Navigation Camera"
        case .pancam:
            return "Panoramic Camera"
        case .minites:
            return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }
}
