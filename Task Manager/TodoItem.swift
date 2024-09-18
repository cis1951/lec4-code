//
//  TodoItem.swift
//  Task Manager
//
//  Created by Anthony Li on 2/8/24.
//

import Foundation

struct TodoItem: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
}
