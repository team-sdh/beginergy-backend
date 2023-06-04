//
//  File.swift
//  
//
//  Created by Hanh Vu on 2023/06/03.
//

import Foundation
import CoreML

struct RegressorInferer {
    
    func inferValue(day: Double) -> String {
        
        do {
            let config = MLModelConfiguration()
            let model = try KrakenRegressor(configuration: config)
            
            let prediction = try model.prediction(Day: day, Start: 20, End: 20.5)
            
            return "Okay"
        } catch {
            return "Error"
        }
    }
}
