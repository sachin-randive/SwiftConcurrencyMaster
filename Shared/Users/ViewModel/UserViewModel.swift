//
//  UserViewModel.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import Foundation
@MainActor
class UserViewModel: ObservableObject {
    @Published var user = [User]()
    private let userService: UserServices
    
    init(userService: UserServices) {
        self.userService = userService
    }
    
    func fetchUsers() async {
        do {
            user =  try await userService.fetchAllUser()
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    func fetchUser() async {
        do {
            
        } catch {
            
        }
    }
}
