//
//  AsyncAwaitServices.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 10/11/25.
//

import Foundation

class AsyncAwaitServices {
    func fetchUsers() async throws -> [User] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let throwError = false  //Bool.random()
        if throwError {
            throw URLError(.badURL)
        } else {
            let users: [User] = [
                .init(username: "Avi Shah", email: "avi@gmail.com", id: 1),
                .init(username: "Vermala Raw", email: "vermala@gmail.com", id: 2),
                .init(username: "Ketan Patil", email: "ketan@gmail.com", id: 3),
                .init(username: "Sachin Randive", email: "sachin@gmail.com", id: 4)
            ]
            print("successfully fetched users")
            return users
        }
    }
    
    // completionHandler another option
    func fetchUsersCompletionHandler(completion: @escaping (Result<[User], Error>) -> Void) {
        let users: [User] = [
            .init(username: "Avi Shah", email: "avi@gmail.com", id: 1),
            .init(username: "Vermala Raw", email: "vermala@gmail.com", id: 2),
            .init(username: "Ketan Patil", email: "ketan@gmail.com", id: 3),
            .init(username: "Sachin Randive", email: "sachin@gmail.com", id: 4)
        ]
        let throwError = Bool.random()
        if throwError {
            completion(.failure(URLError(.badURL)))
        } else {
            completion(.success(users))
        }
    }
}
