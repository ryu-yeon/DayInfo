//
//  DayInfoApp.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

@main
struct DayInfoApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
           HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
