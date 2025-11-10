//
//  AsyncAwaitViewModel.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 10/11/25.
//

import Foundation
@MainActor
class AsyncAwaitViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isUpdating: Bool = false
    @Published var isLoading = false
    
    init() {
        Task {
            do {
                isLoading = true
                self.users = try await fetchUsers()
                print("Succesful task completion..")
                isLoading = false
            } catch {
                print("Error fetching users: \(error)")
            }
        }
    }
    
    func fetchUsers() async throws -> [User] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let users: [User] = [
            .init(username: "Avi Shah", email: "avi@gmail.com", id: 1),
            .init(username: "Vermala Raw", email: "vermala@gmail.com", id: 2),
            .init(username: "Ketan Patil", email: "ketan@gmail.com", id: 3),
            .init(username: "Sachin Randive", email: "sachin@gmail.com", id: 4)
        ]
        
        return users
        
    }
    
    func updateUserEmails() async {
        var result = [User]()
        isUpdating = true
        
        if users.isEmpty {
            print("No users")
        }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        for user in users {
            let newEmail = user.email.replacingOccurrences(of: "gmail", with: "appstuff")
            let newUser = User(username: user.username, email: newEmail, id: user.id)
            result.append(newUser)
        }
        
        isUpdating = false
        
        self.users = result
    }
}
