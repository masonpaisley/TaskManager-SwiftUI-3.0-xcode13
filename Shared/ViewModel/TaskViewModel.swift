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
    @Published var showDatePicker: Bool = false
    
    // add task to core data
    func addTask(context: NSManagedObjectContext) -> Bool{
        let task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    // resetting data
    func resetTaskData() {
        taskTitle = ""
        taskColor = "Green"
        taskDeadline = Date() 
        taskType = "Basic"
    }
}

