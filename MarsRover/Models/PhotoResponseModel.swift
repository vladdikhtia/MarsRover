//
//  PhotosModel.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import Foundation

struct PhotoResponseModel: Codable {
    let photos: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [RoverCamera]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

struct RoverCamera: Codable {
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

let example: PhotoResponseModel = PhotoResponseModel(
    photos: [
        Photo(
            id: 1,
            camera: Camera(
                id: 10,
                name: "FHAZ",
                roverId: 1,
                fullName: "Front Hazard Avoidance Camera"
            ),
            imgSrc: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00100/opgs/edr/fcam/FLB_123456789EDR_F0000000FHAZ00323M_.JPG",
            earthDate: "2012-08-07",
            rover: Rover(
                id: 1,
                name: "Curiosity",
                landingDate: "2012-08-06",
                launchDate: "2011-11-26",
                status: "active",
                maxSol: 4000,
                maxDate: "2023-12-31",
                totalPhotos: 100000,
                cameras: [
                    RoverCamera(name: "FHAZ", fullName: "Front Hazard Avoidance Camera"),
                    RoverCamera(name: "NAVCAM", fullName: "Navigation Camera")
                ]
            )
        ),
        Photo(
            id: 2,
            camera: Camera(
                id: 11,
                name: "MAST",
                roverId: 1,
                fullName: "Mast Camera"
            ),
            imgSrc: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00500/opgs/edr/fcam/FRB_987654321EDR_F0000001MAST00324M_.JPG",
            earthDate: "2013-05-15",
            rover: Rover(
                id: 1,
                name: "Curiosity",
                landingDate: "2012-08-06",
                launchDate: "2011-11-26",
                status: "active",
                maxSol: 4100,
                maxDate: "2024-01-01",
                totalPhotos: 200000,
                cameras: [
                    RoverCamera(name: "MAST", fullName: "Mast Camera"),
                    RoverCamera(name: "CHEMCAM", fullName: "Chemistry and Camera Complex")
                ]
            )
        )
        
    ]
)


