//
//  User.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 10/11/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let username: String
    var email: String
    let id: Int
}
