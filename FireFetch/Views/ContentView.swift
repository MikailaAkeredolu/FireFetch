//
//  ContentView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/6/25.
//

//import SwiftUI

/*
struct ContentView: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Home Screen")
            
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
    ContentView(mainViewModel: MainViewModel())
}

*/


// New ContentView with three hometabs
//
//  ContentView.swift
//  TabViewDemos
//
//  Created by mikaila Akeredolu on 7/8/25.
//

import SwiftUI

// Fact Struct
struct Fact: Codable {
    let text: String
}


struct ContentView: View {
    
@ObservedObject var mainViewModel : MainViewModel //wacthing score keeper
@State private var fact: String = "Get a random fact!"
@State private var isLoading = false
    

    var body: some View {
        
        TabView{
            
            ZStack {
                
                Color.yellow
        
                VStack {
                    Image("hglogotrans")
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){ size, axis in
                            size * 0.6
                        }
                        .clipShape(.capsule)
                        .padding()
                    
                    
                    Text(fact)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: fetchFact) {
                        Text("Get Fact")
                            .padding()
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView()
                            .padding(.vertical, 30)
                    }
                    
                 
                    
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
                            .cornerRadius(8)
                           
                    } .padding(20)
                    
                    
                } // end of vstack
            }//end of zstack
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
             
            }
            
            ProfileView(mainViewModel: mainViewModel)
                .tabItem {
                    //UserProfileView(mainViewModel: viewModel)
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
           
            
            ContactView()
            .tabItem {
                Image(systemName: "person.crop.circle.badge.fill")
                Text("Contact")
            }
            
        } //end of tabs view
        
    } //end of body

    
    //function
    func fetchFact() {
        isLoading = true
        let url = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    fact = "Failed to load fact."
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(Fact.self, from: data)
                DispatchQueue.main.async {
                    fact = decoded.text
                }
            } catch {
                DispatchQueue.main.async {
                    fact = "Failed to parse fact."
                }
            }
        }
        .resume()
    }
    
    
}



// Contact Struct
struct  ContactView : View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            
       
        Form {
            // Section for name
            Section(header: Text("Your Name")) {
                TextField("Enter your name", text: $name)
            }
            
            // Section for email
            Section(header: Text("Your Email")) {
                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
            }

            // Section for message
            Section(header: Text("Your Message")) {
                TextEditor(text: $message)
                    .frame(height: 150) // Make the text box taller
            }

            // Submit button
            Section {
                Button("Submit") {
                    // When button is tapped, show alert
                    showAlert = true
                    name = ""
                    email = ""
                    message = ""
                    
                }
                .foregroundColor(.blue)
            }
         
        }
            
        }.navigationTitle("Book Me")
        
        .alert("Form Submitted", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Thank you! We'll get back to you soon.")
        }
    }
}



// Profile Struct
struct ProfileView: View {
    @ObservedObject var mainViewModel : MainViewModel
    var body: some View {
        ZStack {
            Color.green
            
            UserProfileView(mainViewModel: mainViewModel)
            
        } //end of zstack
    
    }
}



#Preview {
    ContentView(mainViewModel: MainViewModel()) // provide a scorekeeper for view to observe
}

