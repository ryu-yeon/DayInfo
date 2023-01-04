//
//  TodoModel.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import Foundation

import RealmSwift

class Todo: Object, Identifiable {
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var date: String
    @Persisted var color: String
    @Persisted var icon: String
    @Persisted var done: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, detail: String, date: String, color: String, icon: String, done: Bool) {
        self.init()
        self.title = title
        self.detail = detail
        self.date = date
        self.color = "#000000"
        self.icon = icon
        self.done = false
    }
}
