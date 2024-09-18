//
//  TodoItemView.swift
//  Task Manager
//
//  Created by Anthony Li on 9/18/24.
//

import SwiftUI

struct TodoItemView: View {
    @EnvironmentObject var todoModel: TodoModel
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
    }
}

#Preview {
    TodoItemView(
        todo: TodoItem(name: "Finish things", isCompleted: false)
    )
    .environmentObject(TodoModel())
}
