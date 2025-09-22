//
//  TodoItemView.swift
//  Task Manager
//
//  Created by Anthony Li on 9/18/24.
//

import SwiftUI

struct TodoItemView: View {
    @Environment(TodoModel.self) var todoModel
    var todo: TodoItem
    
    var body: some View {
        HStack {
            Text(todo.name)
            Spacer()
            Button(action: {
                todoModel.toggleComplete(id: todo.id)
            }) {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
            }
            .accessibilityLabel(Text(todo.isCompleted ? "Completed" : "Mark as Complete"))
        }
        .opacity(todo.isCompleted ? 0.1 : 1)
        .animation(.default, value: todo.isCompleted)
    }
}

#Preview {
    @Previewable @State var todoModel = TodoModel()
    
    TodoItemView(
        todo: TodoItem(name: "Finish things", isCompleted: false)
    )
    .environment(todoModel)
}
