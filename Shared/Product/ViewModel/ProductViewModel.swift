//
//  ProductViewModel.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products = [Product]()
    private let productService: ProductServices
    
    init(productService: ProductServices) {
        self.productService = productService
    }
    
    func getProducts() async {
        do {
            products = try await productService.fetchProducts()
            
        } catch {
            print(" Failed to fecth products:\(error.localizedDescription)")
        }
    }
}
