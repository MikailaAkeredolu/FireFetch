//
//  RandomImageScatterView.swift
//  FireFetch
//
//  Created by mikaila Akeredolu on 7/23/25.
//

import SwiftUI

struct RandomImageScatterView: View {
    
    // Array of image names (make sure these are in your Assets)
      let imageNames = [
          "Hyundai_kona",
          "Volksawagen-e-golf",
          "model-s",
          "hglogotrans"
      ]
    
    // State to store randomly generated positions
     @State private var randomPositions: [CGPoint] = []

     // Screen size for placement bounds
     @State private var screenSize: CGSize = .zero
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.opacity(0.95).ignoresSafeArea()
                
                // Place images at random positions
                ForEach(0..<imageNames.count, id: \.self) { index in
                    Image(imageNames[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .position(randomPositions.indices.contains(index) ? randomPositions[index] : .zero)
                        .animation(.easeInOut(duration: 0.5), value: randomPositions)
                }
                
                VStack {
                    Spacer()
                    
                    Button("Shuffle Images") {
                        generateRandomPositions(in: geo.size)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding(.bottom, 40)
                }
            }
            .onAppear {
                screenSize = geo.size
                generateRandomPositions(in: geo.size)
            }
        }
        
 
    }
    
    // Generate new random positions within screen bounds
    private func generateRandomPositions(in size: CGSize) {
        randomPositions = imageNames.map { _ in
            let x = CGFloat.random(in: 60...(size.width - 60))
            let y = CGFloat.random(in: 100...(size.height - 120))
            return CGPoint(x: x, y: y)
        }
    }
    
}

#Preview {
    RandomImageScatterView()
}
