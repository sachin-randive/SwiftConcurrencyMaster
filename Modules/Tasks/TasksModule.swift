//
//  TasksModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 11/11/25.
//

import SwiftUI

struct TasksModule: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    // @State private var task: Task<(), any Error>?
    @State private var selectedUserId: Int?
    @State private var isExecuted = false
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.users, id: \.id) { user in
                        NavigationLink(value: user, label: {
                            VStack(alignment: .leading) {
                               
                                if viewModel.isUpdating {
                                    ProgressView()
                                } else {
                                    Text("\(user.username)")
                                    Text("\(user.email)")
                                }
                            }
                        })
//                        .onTapGesture {
//                            self.selectedUserId = user.id
//                        }
                    }
                }
            }
//            .task(id: selectedUserId) {
//                print("Update userid: \(String(describing: selectedUserId))")
//            }
            
            .task {
                guard !isExecuted else {
                    print("Task already ran..")
                    return }
                await viewModel.fetchUsers()
                isExecuted = true
            }
            .navigationDestination(for: User.self, destination:{ user in
                Text(user.username)
            })
        }
        
        /* .onDisappear {
         self.task?.cancel()
         }
         .onAppear {
         self.task = Task(priority: .high) {
         print("started task 1..")
         await viewModel.fetchUsers()
         print("Completed task 1..")
         print("Users count \(viewModel.users.count)")
         }
         Task(priority: .low) {
         print("started task 2..")
         //await do something
         print("Completed task 2..")
         }
         Task(priority: .background) {
         print("started task 3..")
         //await do something
         print("Completed task 3..")
         }
         }*/
    }
}

#Preview {
    TasksModule()
}
