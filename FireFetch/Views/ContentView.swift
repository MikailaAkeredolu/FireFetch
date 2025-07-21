//  ContentView.swift
//  TabViewDemos
//  Created by mikaila Akeredolu on 7/8/25.
//

import SwiftUI
import Observation

struct ContentView: View {
    
@Environment(ApplicationData.self) private var appData
    
@ObservedObject var mainViewModel : MainViewModel //wacthing score keeper
@State private var fact: String = "Get a random fact!"
@State private var isLoading = false
    
    var body: some View {
        
        TabView{
            
            //Home
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
         
         
            //Profile
            ProfileView(mainViewModel: mainViewModel)
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
            
            
            //Fact
            FactView(mainViewModel: mainViewModel)
                .tabItem {
                    Image(systemName: "quote.bubble")
                    Text("Facts")
                }
           
            
            //Contact
            ContactView()
            .tabItem {
                Image(systemName: "person.crop.circle.badge.fill")
                Text("Contact")
            }
            
        } //end of TabView
        
    } //end of content body
    
    
} // end of ContentView



//****************************Models

//Car Model
struct Car: Identifiable, Hashable{
    let id = UUID()
    var cover: String
    var make: String
    var model: String
    var year: Int
    var msrp: String
    var drive: String
    var epaRange: String
    var selected: Bool
    
}

// Fact Model
struct Fact: Codable {
    let text: String
}


//****************************Views


//Home View
struct HomeView: View {
    
    @Environment(ApplicationData.self) private var appData
    
    var body: some View {
        NavigationView {
            
            List(appData.userData){ car in
                
                NavigationLink(destination: CarDetailView(car: car)) {
                    
                    VStack{
                        HStack{
                            CellCar(car: car)
                        }
                    }
                    
                }.navigationTitle(Text("Electric Vehicles"))
                    .navigationBarTitleDisplayMode(.inline)
                
            }
        }
    }
}


//Single Car cell view
struct CellCar: View {
    
    let car: Car
    
    var body: some View {
        HStack{
            Image(car.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
            
            VStack(alignment: .leading, spacing: 2){
                
                HStack {
                    Text(car.make)
                        .font(.headline)
                    
                    Text(car.model)
                        .font(.subheadline)
                }
                
                Text("\(car.year)")
            }
        }
    }
}


//Car Details View
struct CarDetailView: View {
    
    let car: Car

    var body: some View {
        VStack {
           
            Image(car.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 200)
            
            Text("Make: \(car.make)")
                .font(.largeTitle)
                .bold()

            Text("Model: \(car.model)")
                .font(.title2)
                .padding()
            
            Text(car.drive)
                .font(.title2)
            
            Text("$\(car.msrp)")
                .font(.title2)
                .padding()
            
            Text("Range: \(car.epaRange) miles")
                .font(.title2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .padding()


        }
        .navigationTitle(car.model)
        .navigationBarTitleDisplayMode(.inline)
    }
}



//Fact View
struct FactView: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    @State private var fact: String = "Get a random fact!"
    @State private var isLoading = false
    
    var body: some View {
        
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

                        }
                    }
    }
    
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



// Profile View
struct ProfileView: View {
    @ObservedObject var mainViewModel : MainViewModel
    var body: some View {
        ZStack {
            Color.green
            
            UserProfileView(mainViewModel: mainViewModel)
            
        }
    
    }
}


// Contact View
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




#Preview {
    ContentView(mainViewModel: MainViewModel())
        .environment(ApplicationData.shared)
}



