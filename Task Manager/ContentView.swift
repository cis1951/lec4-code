//
//  ContentView.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var todos = [TodoItem]()
    
    var body: some View {
        List(todos) { todo in
            Text(todo.name)
        }
    }
}

#Preview {
    ContentView()
}
