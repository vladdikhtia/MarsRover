//
//  MarsRoverApp.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let persistenceController = PersistenceController.shared
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let roverViewModel = RoverViewModel()
        let homeView = HomeView(viewModel: roverViewModel)
        //        let contentView = ContentView()
        //            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: homeView)
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}


