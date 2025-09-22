//
//  ContentView.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(TodoModel.self) var todoModel
    @State private var newTodoName = "" // For handling user input
    
    var body: some View {
        VStack {
            TextField("Enter new todo", text: $newTodoName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(action: addNewTodo) {
                Text("Add Todo")
            }
            .padding()
            .disabled(newTodoName.isEmpty)
            
            List(todoModel.todos) { todo in
                TodoItemView(todo: todo)
            }
        }
    }
    
    private func addNewTodo() {
        let newTodo = TodoItem(name: newTodoName, isCompleted: false)
        todoModel.createTodo(todo: newTodo)
        newTodoName = "" // Reset input field
    }
}

#Preview {
    @Previewable @State var todoModel = TodoModel()
    
    ContentView()
        .environment(todoModel)
}
