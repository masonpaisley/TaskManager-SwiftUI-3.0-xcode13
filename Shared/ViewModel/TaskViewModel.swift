//
//  TaskViewModel.swift
//  TaskManager (iOS)
//
//  Created by jinzhao wang on 2022/8/31.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    // New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Green"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
}

