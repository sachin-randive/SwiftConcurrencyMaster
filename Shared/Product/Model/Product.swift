//
//  Product.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    
    var productOwner: User?
}
