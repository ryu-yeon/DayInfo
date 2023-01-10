//
//  CustomPersistenceContorller.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/10.
//

import UIKit
import CoreData

class NSCustomPersistentController: NSPersistentCloudKitContainer {
    
    override class func defaultDirectoryURL() -> URL {
        let storeURL = AppGroup.facts.containerURL.appendingPathComponent("Item.sqlite")
        return storeURL
    }
}
