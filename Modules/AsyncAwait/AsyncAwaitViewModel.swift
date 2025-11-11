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
    @Published var errorMessage: String?
    
    let services = AsyncAwaitServices()
    
    init() {
//        Task {
//            await fetchUsers()
//        }
        
        fetchDataWithCompletion()
    }
    
    func fetchUsers() async  {
        isLoading = true
        defer {isLoading = false}
        do {
            self.users = try await services.fetchUsers()
            print("Task completed..")
        } catch {
            self.errorMessage = "An error ocurred"
            print("Error fetching users: \(error)")
        }
    }
    
    // completionHandler call
    
    func fetchDataWithCompletion() {
        services.fetchUsersCompletionHandler { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.errorMessage = "An error ocurred: \(error)"
            }
        }
    }
    
    func updateUserEmails() async {
        var result = [User]()
        isUpdating = true
        
        if users.isEmpty {
            print("No users")
        }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        for user in users {
            let newEmail = user.email.replacingOccurrences(of: "gmail", with: "SwiftApp")
            let newUser = User(username: user.username, email: newEmail, id: user.id)
            result.append(newUser)
        }
        isUpdating = false
        self.users = result
    }
}
