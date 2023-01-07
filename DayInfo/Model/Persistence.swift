//
//  Persistence.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/06.
//

import CoreData

struct PersistenceController {
    // MARK: - 1. PERSISTENT CONTROLLER
    static let shared = PersistenceController()

    // MARK: - 2. PERSISTENT CONTAINER
    let container: NSPersistentContainer
    
    // MARK: - INITIALIZATION (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Item")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - 4. PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContenxt = result.container.viewContext
        for i in 0..<5 {
            let newItem = Todo(context: viewContenxt)
            newItem.date = Date()
            newItem.title = "Sample task No\(i)"
            newItem.done = false
            newItem.id = UUID()
            newItem.content = "sampel contant\(i)"
            newItem.color = "#000000"
        }
        do {
            try viewContenxt.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
