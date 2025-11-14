//
//  RefreshableModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 14/11/25.
//

import SwiftUI

struct RefreshableModule: View {
    @StateObject private var viewModel = UserViewModel(userService: UserServices())
    var body: some View {
        List {
            ForEach(viewModel.user, id: \.id) { user in
                Text(user.username)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            await viewModel.fetchUsers()
        }
        .refreshable {
            viewModel.user.removeAll()
            try? await Task.sleep(for: .seconds(2))
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    RefreshableModule()
}
