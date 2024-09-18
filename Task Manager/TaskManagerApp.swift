//
//  TaskManagerApp.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject var todoModel = TodoModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(todoModel)
        }
    }
}
