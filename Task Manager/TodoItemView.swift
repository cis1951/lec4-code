//
//  TodoItemView.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

struct TodoItemView: View {
    @Binding var todo: Todo
    
    var body: some View {
        VStack(alignment: .leading) {
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
            Text("\(todo.deadline)")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
        .opacity(todo.isCompleted ? 0.1 : 1)
        .animation(.default, value: todo.isCompleted)
    }
}

private struct TodoItemViewPreview: View {
    @State var todo = Todo(name: "Preview Todo", isCompleted: true)
    
    var body: some View {
        TodoItemView(todo: $todo)
    }
}

#Preview {
    TodoItemViewPreview()
}
