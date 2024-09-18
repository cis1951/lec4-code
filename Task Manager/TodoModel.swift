//
//  TodoModel.swift
//  Task Manager
//
//  Created by Anthony Li on 9/18/24.
//

import Foundation

class TodoModel: ObservableObject {
    @Published private(set) var todos: [TodoItem] = []
    
    func createTodo(todo: TodoItem) {
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
