//
//  Task_ManagerApp.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import SwiftUI

@main
struct Task_ManagerApp: App {
    @StateObject var todoModel = TodoModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(todoModel)
        }
    }
}
