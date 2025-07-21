//
//  UserProfileView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/13/25.
// This ibviiosly our user profile view;s code

import SwiftUI

struct UserProfileView: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        ZStack {
                    Color.yellow.ignoresSafeArea()
                    
                VStack{
                    
                    Image("hglogotrans")
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){ size, axis in
                            size * 0.6
                        }
                        .clipShape(.capsule)
                   
            
                    Text("Welome, \(mainViewModel.email)")
                    .padding()
                    
                    //display user's username
                    Text("@" + (mainViewModel.databaseUser?.username ??  "No user logged in") )
                                   .font(.largeTitle)
                
                    
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                    
                    Text("You are now signed in")
                        .padding()

                    NavigationLink{
                        ContentView(mainViewModel: mainViewModel)
                    } label: {
                        
                            Text("Get Started")
                        
                            Image(systemName: "house.fill")
                          
                        
                    }.font(.largeTitle)
                     .foregroundStyle(.black)
                     .padding(.bottom, 150)
                    
                }
        }.onAppear {
            mainViewModel.fetchCurrentUserEmail()
            mainViewModel.fetchUserData()
        }
        
    }
}

#Preview {
    UserProfileView(mainViewModel: MainViewModel())
}
