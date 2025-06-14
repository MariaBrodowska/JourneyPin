//
//  journeypinApp.swift
//  journeypin
//
//  Created by maria on 27/05/2025.
//

import SwiftUI

@main
struct journeypinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
