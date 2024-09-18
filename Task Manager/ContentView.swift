//
//  ContentView.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var todos = [TodoItem]()
    @State private var newTodoName = "" // For handling user input
    
    var body: some View {
        VStack {
            TextField("Enter new todo", text: $newTodoName)
                .padding()
            
            Button(action: addNewTodo) {
                Text("Add Todo")
            }
            .padding()
            .disabled(newTodoName.isEmpty)
            
            List($todos) { $todo in
                TodoItemView(todo: $todo)
            }
        }
    }
    
    private func addNewTodo() {
        let newTodo = TodoItem(name: newTodoName, isCompleted: false)
        todos.append(newTodo)
        newTodoName = "" // Reset input field
    }
}

#Preview {
    ContentView()
}
