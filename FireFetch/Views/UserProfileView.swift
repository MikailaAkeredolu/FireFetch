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
                       
                    NavigationLink{
                        ContentView(mainViewModel: mainViewModel)
                    } label: {
                            Image(systemName: "gear.circle")
                    }
                        
                }
         }
        
    }
}

#Preview {
    UserProfileView(mainViewModel: MainViewModel())
}
