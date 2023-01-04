//
//  TodoRepository.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import Foundation

import RealmSwift

final class TodoRepository {
    
    let localRealm = try! Realm()
    
    static let shared = TodoRepository()
    
    func fetchTodo() -> [Todo] {
        print(localRealm.configuration.fileURL!)
        return Array(localRealm.objects(Todo.self))
    }
    
    func addTodo(todo: Todo) {
        try! localRealm.write({
            localRealm.add(todo)
        })
    }
    
    func deleteTodo(todo: Todo) {
        try! localRealm.write {
            localRealm.delete(todo)
        }
    }
    
    func updateDone(_ done: Bool, todo: Todo) {
        try! localRealm.write {
            todo.done = done
        }
    }
    
    func updateColor(_ color: String, todo: Todo) {
        try! localRealm.write {
            todo.color = color
        }
    }
}
