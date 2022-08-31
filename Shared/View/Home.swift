//
//  Home.swift
//  TaskManager (iOS)
//
//  Created by jinzhao wang on 2022/8/31.
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = .init()
    // matched geometry namespace
    @Namespace var animation
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut)
    var tasks: FetchedResults<Task>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading) {
                    Text("Welcome Back")
                        .font(.callout)
                    Text("Here's Update Today.")
                        .font(.title2.bold() )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                CustomSegmentedBar()
                    .padding(.top, 5 )
                
                TaskView()
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            // add button
            Button {
                taskModel.openEditTask.toggle()
            } label: {
                Label {
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            // linear gradient bg
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
//            .background {
//
//            }
        }
        .fullScreenCover(isPresented: $taskModel.openEditTask) {
            taskModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(taskModel)
        }
        
    }
    
    // TaskView
    @ViewBuilder
    func TaskView() -> some View {
        LazyVStack(spacing: 20) {
            ForEach(tasks) { task in
                TaskRowView(task: task)
            }
        }
        .padding(.top, 20)
    }
    
    // TaskRowView
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(task.type ?? "")
                .font(.callout)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background {
                    Capsule()
                        .fill(.gray.opacity(0.3))
                }
            Spacer()
            
            if !task.isCompleted {
                Button {
                    
                } label: {
                    Image(systemName:  "square.and.pencil")
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Green"))
        }
    }
    
    // Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Task Done"]
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if taskModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation { taskModel.currentTab = tab }
                    }
            }
           
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
