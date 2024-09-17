//
//  TodoModel.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import Foundation

class TodoModel: ObservableObject {
    @Published private(set) var todos: [Todo] = []
    
    func createTodo(todo: Todo) {
        todos.append(todo)
    }
    
    func toggleComplete(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            if todos[index].isCompleted {
                todos[index].isCompleted = false
            } else {
                todos[index].isCompleted = true
                todos.move(fromOffsets: IndexSet(integer: index), toOffset: todos.endIndex)
            }
        }
    }
}
