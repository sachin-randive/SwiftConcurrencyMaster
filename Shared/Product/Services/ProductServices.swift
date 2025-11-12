//
//  ProducrServices.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import Foundation

struct ProductServices {
    
    func fetchProducts() async throws -> [Product] {
        var result  = [Product]()
        
        for i in 1...5 {
            let url = URL(string: "https://fakestoreapi.com/products/\(i)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let product = try JSONDecoder().decode(Product.self, from: data)
            result.append(product)
        }
        return result
    }
}
