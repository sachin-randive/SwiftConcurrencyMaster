//
//  TaskGroupModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import SwiftUI

@MainActor
class taskGroupViewModel: ObservableObject {
    @Published var products = [Product]()
    
    private let productService = ProductServices()
    private let userService = UserServices()
    
    
    func getProducts() async {
        print("Fetching products..") // 1
        do {
            products = try await productService.fetchProducts()
            print("Product fetch complete..") // 2
            try await getProductOwnersWithTaskGroup()
        } catch {
            print("Failed to fetch users for products:\(error)")
        }
    }
    
    func getProductOwnersWithTaskGroup() async throws {
        print("Entered task group function..") // 3
        try await withThrowingTaskGroup(of: User.self) { group in
            
            for product in products {
                group.addTask {
                    let user =  try await self.userService.fetchUser(product.id)
                    return user
                }
            }
            print("Finished looping thru products")
            
            for try await user in group {
                print("User id in task group async loop: \(user.id)")
                let index = user.id - 1
                self.products[index].productOwner = user
            }
            
            print("Finished user task group..")
            
        }
    }
    
}

struct TaskGroupModule: View {
    
    //    @StateObject private var userViewModel = UserViewModel(userService: UserServices())
    //    @StateObject private var productViewModel = ProductViewModel(productService: ProductServices())
    
    @StateObject private var productViewModel = taskGroupViewModel()
    
    var body: some View {
        List {
            Section("Products") {
                ForEach(productViewModel.products) { product in
                    HStack(spacing: 16) {
                        Text("\(product.id)")
                        VStack(alignment: .leading) {
                            
                            if let owner = product.productOwner {
                                Text("\(owner.username)")
                                
                            }
                            Text(product.title)
                                .lineLimit(1)
                            Text("$\(product.price)")
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        
                    }
                }
            }
            
            //            Section("Users") {
            //                ForEach(userViewModel.user) { user in
            //                    Text(user.username)
            //                }
            //
            //            }
        }
        
        //        .task { await userViewModel.fetchUsers()}
        .task { await productViewModel.getProducts()}
    }
}

#Preview {
    TaskGroupModule()
}
