//
//  ApplicationData.swift

//  If not fetching data from an api then this is how you can create your own JsonFile / API data locally
//
//  Created by mikaila Akeredolu on 7/20/25.
//

import Foundation

import Observation

@Observable class ApplicationData: @unchecked Sendable {
    
    //Proerties
    var userData: [Car] = []
    static let shared: ApplicationData = ApplicationData()
    
   
    private init(){  //Initialize your own data as if you are fetching from an API
        
        //Make as many Car objects you like within this array
        userData = [
            
            Car(cover: "Hyundai_kona", make: "Hyundai", model: "Kona", year: 2024, msrp:"34 - 42k", drive: "Front-Wheel Drive", epaRange: "200 - 261", selected: false),
            Car(cover: "Volksawagen-e-golf", make: "Volkswagen", model: "E-Golf", year: 2019, msrp:"32 - 40k", drive: "Front-Wheel Drive", epaRange: "125", selected: false),
            Car(cover: "model-s", make: "Tesla", model: "Model S", year: 2026, msrp:"86 - 101k", drive: "All-Wheel Drive", epaRange: "368-410", selected: false),
            
            Car(cover: "Hyundai_kona", make: "Hyundai", model: "Kona", year: 2024, msrp:"34 - 42k", drive: "Front-Wheel Drive", epaRange: "200 - 261", selected: false),
            Car(cover: "Volksawagen-e-golf", make: "Volkswagen", model: "E-Golf", year: 2019, msrp:"32 - 40k", drive: "Front-Wheel Drive", epaRange: "125", selected: false),
            Car(cover: "model-s", make: "Tesla", model: "Model S", year: 2026, msrp:"86 - 101k", drive: "All-Wheel Drive", epaRange: "368-410", selected: false),
            
            Car(cover: "Hyundai_kona", make: "Hyundai", model: "Kona", year: 2024, msrp:"34 - 42k", drive: "Front-Wheel Drive", epaRange: "200 - 261", selected: false),
            Car(cover: "Volksawagen-e-golf", make: "Volkswagen", model: "E-Golf", year: 2019, msrp:"32 - 40k", drive: "Front-Wheel Drive", epaRange: "125", selected: false),
            Car(cover: "model-s", make: "Tesla", model: "Model S", year: 2026, msrp:"86 - 101k", drive: "All-Wheel Drive", epaRange: "368-410", selected: false),
            
            Car(cover: "Hyundai_kona", make: "Hyundai", model: "Kona", year: 2024, msrp:"34 - 42k", drive: "Front-Wheel Drive", epaRange: "200 - 261", selected: false),
            Car(cover: "Volksawagen-e-golf", make: "Volkswagen", model: "E-Golf", year: 2019, msrp:"32 - 40k", drive: "Front-Wheel Drive", epaRange: "125", selected: false),
            Car(cover: "model-s", make: "Tesla", model: "Model S", year: 2026, msrp:"86 - 101k", drive: "All-Wheel Drive", epaRange: "368-410", selected: false)
        ]
    }
    
}

