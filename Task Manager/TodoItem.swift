//
//  TodoItem.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID()
    var name: String
    var deadline = Date()
    var isCompleted: Bool
}
