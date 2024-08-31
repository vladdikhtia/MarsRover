//
//  NetworkManager.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import Foundation
import Combine
// http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG
// http://mars.nasa.gov/mer/gallery/all/1/p/4037/1P486568465EFFCNJDP2407L2M1-BR.JPG

//    https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY - old
//  with paging https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?earth_date=2015-6-3&page=2&api_key=DEMO_KEY
class NetworkManager {
    @Published var returnedPhotos: [Photo] = []
    var cancellables = Set<AnyCancellable>()
    
    static let instance = NetworkManager() // singleton
    
    private init(){
        getData()
    }
//    https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?earth_date=2015-6-3&api_key=DEMO_KEY - new
    func getData() {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&page=1&api_key=DEMO_KEY") else {
            return
        }
                
        URLSession.shared.dataTaskPublisher(for: url)
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
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
