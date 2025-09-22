//
//  TaskManagerApp.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @State var todoModel = TodoModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(todoModel)
        }
    }
}
