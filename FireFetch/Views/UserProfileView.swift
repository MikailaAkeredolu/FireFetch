//
//  UserProfileView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/13/25.
//

import SwiftUI

struct UserProfileView: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        ZStack {
                    Color.yellow.ignoresSafeArea()
                    
                VStack{
                    
                    Text("Welome, \(mainViewModel.email)")
                    .padding()
                    
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
                    
                    NavigationLink{
                        ContentView(mainViewModel: mainViewModel)
                    } label: {
                            Image(systemName: "gear.circle")
                    }
                
                  
                }
        }.onAppear {
            mainViewModel.fetchCurrentUserEmail()
        }
        
    }
}

#Preview {
    UserProfileView(mainViewModel: MainViewModel())
}
