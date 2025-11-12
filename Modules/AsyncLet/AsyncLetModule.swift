//
//  AsyncLetModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 12/11/25.
//

import SwiftUI
//Model
struct UserStates {
    let posts: Int
    let followers: Int
    let following: Int
}

// ViewModel
@MainActor
class AsyncLetModuleViewModel: ObservableObject {
    @Published var userState: UserStates?
    
    func fetchUserState() async {
        async let posts = fetchPosts()
        async let followers = fetchFollowers()
        async let following = fetchFollowing()
        
        self.userState = await .init(posts: posts, followers: followers, following: following)
    }
    
    private func fetchPosts() async -> Int {
        print("Fetching posts...")
        try? await Task.sleep(for: .seconds(3))
        print("Got posts")
        return 13
    }
    
    private func fetchFollowers() async -> Int {
        print("Fetching Followers...")
        try? await Task.sleep(for: .seconds(2))
        print("Got Followers")
        return 200
    }
    
    private func fetchFollowing() async -> Int {
        print("Fetching Following...")
        try? await Task.sleep(for: .seconds(1))
        print("Got Following")
        return 3
    }
    
    
    
    
}
struct AsyncLetModule: View {
    @StateObject var viewModel = AsyncLetModuleViewModel()
    
    var body: some View {
      
        VStack(alignment:.center, spacing: 10) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            Divider()
            HStack {
                if let viewModelUserState = viewModel.userState {
                    VStack {
                        Text("\(viewModelUserState.posts)")
                        Text("Posts")
                    }
                    .frame(width: 100)
                    VStack {
                        Text("\(viewModelUserState.followers)")
                        Text("followers")
                    }
                    .frame(width: 100)
                    VStack {
                        Text("\(viewModelUserState.following)")
                        Text("following")
                    }
                    .frame(width: 100)
                } else {
                    Text("Loading...")
                }
            }
           
            .task {
                await  viewModel.fetchUserState()
            }
            .padding(.vertical)
           
        }
        .background(Color.purple.opacity(0.2))
        Spacer()
    }
}

#Preview {
    AsyncLetModule()
}
