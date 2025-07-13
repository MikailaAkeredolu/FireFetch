//
//  ContentView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/6/25.
//

import SwiftUI

     //MainView
struct ContentView: View {
    
    //Object from class MainViewModel: ObservableObject {}
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("You are now signed in")
            
            Button{
                mainViewModel.signOut()
            } label: {
                Text("Sign Out")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                   
            } .padding(20)
            
        }
    
    }
}

#Preview {
    //Connected with @StateObject viewModel in @main
    ContentView(mainViewModel: MainViewModel())
}
