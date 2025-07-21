//
//  FireFetchApp.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/6/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("checking if firebase configured successfully")
    return true
  } // end of fuction
    
    
} //end of class

@main
struct FireFetchApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //Use @StateObject here
    @StateObject private var viewModel = MainViewModel()
    
    @State private var rootViewID = UUID() //create unique identiefier and inject itto nav stack
    
    @State private var appData = ApplicationData.shared
    
    
    var body: some Scene {
 
        WindowGroup {
     
            NavigationStack {
                currentView()
                    
                
            }
            .environment(appData)
            .id(rootViewID) //resets the view heirarchy
                .onReceive(viewModel.$isAuthenticated) { isAuthenticated in
                    if !isAuthenticated {
                        print("user is signed out and now resetting view heirarchy")
                        rootViewID = UUID() //forces the nav stack to reset itself with new id
                    }
                  
                } //end of onReceived
        } //end of WindowGroup
        
    } //end of body
    
    
    //Use a view builder modifier
    //dismiss when gear is clicked to logout user
    @ViewBuilder
    private func currentView() -> some View {
        if viewModel.isAuthenticated {
            UserProfileView(mainViewModel: viewModel)
        } else {
            AuthView(mainViewModel: viewModel)
        }
    }
    
    
} //end of struct
