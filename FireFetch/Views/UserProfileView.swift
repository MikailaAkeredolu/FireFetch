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
                    
                }
        }.onAppear {
            mainViewModel.fetchCurrentUserEmail()
        }
        
    }
}

#Preview {
    UserProfileView(mainViewModel: MainViewModel())
}
