//
//  UserProfileView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/13/25.
// This ibviiosly our user profile view;s code
import Foundation
import SwiftUI
import UIKit


class ProfileImageManager {
    static let shared = ProfileImageManager()
    private init() {}

    private let filename = "profile.jpg"

    private var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(filename)
    }

    func save(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }

    func load() -> UIImage? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        return UIImage(contentsOfFile: fileURL.path)
    }

    func delete() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}

//Image picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


//start of exisiting profileView

struct UserProfileView: View {
    
    //variables
    @State private var profileImage: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        ZStack {
                    Color.yellow.ignoresSafeArea()
                    
                VStack{
                    
                    Text("Welome,")
                        .font(.largeTitle)
                    .padding()
                    
                    //display user's username
                    Text("@" + (mainViewModel.databaseUser?.username ??  "Unknown") )
                                   .font(.largeTitle)
                
                    
                    //before picking image
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 100))
                            )
                    }

                    Button("Change Picture") {
                        showingImagePicker = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    //delete pic
                    // Button("Delete Profile Picture") {
                    //                      ProfileImageManager.shared.delete()
                    //                        profileImage = nil
                    //                    }
                    
                    NavigationLink{
                        ContentView(mainViewModel: mainViewModel)
                    } label: {
                        
                            Text("Get Started")
                        
                            Image(systemName: "house.fill")
                          
                        
                    }.font(.largeTitle)
                     .foregroundStyle(.black)
                     .padding(.bottom, 150)
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: {
                    if let selected = selectedImage {
                        ProfileImageManager.shared.save(image: selected)
                        profileImage = selected
                    }
                }) {
                    ImagePicker(image: $selectedImage)

                }
        }
        .onAppear {
            mainViewModel.fetchCurrentUserEmail()
            mainViewModel.fetchUserData()
            profileImage = ProfileImageManager.shared.load()
        }
    }
}

#Preview {
    UserProfileView(mainViewModel: MainViewModel())
}
