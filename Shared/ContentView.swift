//
//  ContentView.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/31.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline )
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
