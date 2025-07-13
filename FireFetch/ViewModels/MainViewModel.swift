//
//  MainViewModel.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/6/25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth


@MainActor
class MainViewModel: ObservableObject {
    
    //Toast Variables
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    
    //Auth Variables
    @Published var email = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var showSignInView: Bool = false
    
    @Published var authUserData: UserData? = nil // Userdata Model
    @Published var isAuthenticated: Bool = false
    
    
//AUth Methods
    
    init(){
        checkAuthenticationStatus()
    }
    
//To determine if not to show a user AuthView if already logged in
// DispatchQueue refers to the mainthread, where UI updates happen
    
    private func checkAuthenticationStatus() {

        DispatchQueue.main.async {
//unwrap user with Auth FirebaseAuth to get the currentUser
            if let user = Auth.auth().currentUser {
                
                self.isAuthenticated = true
                self.authUserData = UserData(user: user)
                
            }else{
                
                self.isAuthenticated = false
                self.authUserData = nil
                
            }
            
        }
        
    }
    
    
    
//Sign Out Functionality
    
    func signOut() {
    
        do {
            //signout of firebase
            try Auth.auth().signOut()
            
            //set user to false and nil
            DispatchQueue.main.async {
                self.isAuthenticated = false
                self.authUserData = nil
            }
            
        } catch {
            print("Error signing out: \(error)")
        }
        
    }
    

    
//Handle Auth Error
    
    private func handleAutherror(_ error: Error) {
        if let error = error as? NSError,
           let errorMessage = error.userInfo[NSLocalizedDescriptionKey] as? String {
                showToastMessage(errorMessage)
        }else{
                showToastMessage("An unknown error occured")
        }
    }
  
    
    
//ShowToast Function
//Turn toast message off by running a timer to dismiss itself 8secs

    private func showToastMessage(_ message: String) {
        
    DispatchQueue.main.async {
            
        self.toastMessage = message
        self.showToast = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.showToast = false
            }
            
        }
    }
    

    
//Sign In Functionality
    
    func signIn()  {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password are empty")
            return
        }
        
        //async await functionality
        Task{
            do {
                
                let result =  try await Auth.auth().signIn(withEmail: email, password: password)
                
                //Grab user property from result
                DispatchQueue.main.async {
                    self.authUserData = UserData(user: result.user)
                    self.isAuthenticated = true
                }
                
                print("Signed in successfully")
                
            } catch {
                DispatchQueue.main.async {
                    self.handleAutherror(error)
                }
            }
            
        }
        
    }
    
    //SignUp Functionaility
    func signUp() {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password are empty")
            return
        }
        
        Task{
            do {
                
                let result =  try await Auth.auth().createUser(withEmail: email, password: password)
                
                DispatchQueue.main.async {
                    self.authUserData = UserData(user: result.user)
                    self.isAuthenticated = true
                }
                
                print("Created user successfully")
                
            } catch {
                DispatchQueue.main.async {
                    self.handleAutherror(error)
                }
            }
        }
        
    }
    
    
    
    
    
    
    
} //end of class


extension MainViewModel {
    func isValidEmail( ) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return !password.isEmpty && emailPredicate.evaluate(with: email)
    }
}
