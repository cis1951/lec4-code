//
//  TodoItemView.swift
//  Task Manager
//
//  Created by Anthony Li on 9/18/24.
//

import SwiftUI

struct TodoItemView: View {
    @Binding var todo: TodoItem
    
    var body: some View {
        HStack {
            Text(todo.name)
            Spacer()
            Button(action: {
                todo.isCompleted.toggle()
            }) {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
            }
            .accessibilityLabel(Text(todo.isCompleted ? "Completed" : "Mark as Complete"))
        }
    }
}

private struct TodoItemPreview: View {
    @State var todo = TodoItem(name: "Finish things", isCompleted: false)
    
    var body: some View {
        TodoItemView(todo: $todo)
    }
}

#Preview {
    TodoItemPreview()
}
