//
//  UserServices.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import Foundation

struct UserServices {
    func fetchAllUser() async throws -> [User] {
        let url = URL(string: "https://fakestoreapi.com/users/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUser(_ id: Int) async throws -> User {
        let url = URL(string: "https://fakestoreapi.com/users/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let user = try JSONDecoder().decode(User.self, from: data)
        return user
    }
}
