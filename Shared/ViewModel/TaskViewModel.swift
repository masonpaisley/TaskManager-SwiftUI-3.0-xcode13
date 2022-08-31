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
    @Published var taskIsCompleted: Bool = false
    
    @Published var showDatePicker: Bool = false
    
    @Published var editTask: Task?
    
    // add task to core data
    func addTask(context: NSManagedObjectContext) -> Bool{
        // updating existing data in core data
        var task: Task!
        if let editTask = editTask {
            task = editTask
        } else {
            task = Task(context: context)
        }
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
    func resetTaskData() -> Void {
        taskTitle = ""
        taskColor = "Yellow"
        taskDeadline = Date()
        taskType = "Basic"
        // taskIsCompleted = false
    }
    
    // if edit task is available then setting exisiting data
    func setupTask() {
        if let editTask = editTask {
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Green"
            taskTitle = editTask.title ?? ""
            taskDeadline = editTask.deadline ?? Date()
        }
    }
}
