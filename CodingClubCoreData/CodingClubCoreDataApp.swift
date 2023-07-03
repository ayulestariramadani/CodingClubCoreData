//
//  CodingClubCoreDataApp.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI

@main
struct CodingClubCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
