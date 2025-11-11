//
//  ContentView.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 10/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    var body: some View {
       NavigationStack {
            VStack {
               Button("Show") {
                   show.toggle()
               }
           }
            .navigationDestination(isPresented: $show) {
                TasksModule()
            }
           
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
