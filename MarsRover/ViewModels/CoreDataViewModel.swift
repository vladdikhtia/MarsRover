//
//  CoreDataViewModel.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var filters: [FilterEntity] = []
    
    init() {
        fetchFilters()
    }
    
    // CRUD
    func fetchFilters() {
        let request = NSFetchRequest<FilterEntity>(entityName: "FilterEntity")
        request.fetchLimit = 10
        
        do {
            self.filters = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Some error occured while fetching: \(error.localizedDescription)")
            fatalError()
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save filters: \(error.localizedDescription)")
            fatalError()
        }
    }
    
    func addFilter(roverName: String, cameraName: String, date: String) {
        let newFilter = FilterEntity(context: viewContext)
        newFilter.rover = roverName
        newFilter.camera = cameraName
        newFilter.date = date
        
        save()
        fetchFilters()
        print("Add")
    }
    
    func deleteFilter(filter: FilterEntity) {
        viewContext.delete(filter)
        save()
        fetchFilters()
        print("Delete")
    }
    
    //update
}
