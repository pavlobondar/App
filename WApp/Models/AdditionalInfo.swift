//
//  AdditionalInfo.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

enum AdditionalInfo: Identifiable {
    case feelslikeC(feelslikeC: Double)
    case humidity(humidity: Int)
    case windMph(windMph: Double)
    
    var id: String {
        return UUID().uuidString
    }
    
    var icon: String {
        switch self {
        case .feelslikeC:
            return "thermometer.low"
        case .humidity:
            return "humidity"
        case .windMph:
            return "wind"
        }
    }
    
    var title: String {
        switch self {
        case .feelslikeC(let feelslikeC):
            return "\(feelslikeC)°"
        case .humidity(let humidity):
            return "\(humidity) %"
        case .windMph(let windMph):
            return "\(windMph) Mph"
        }
    }
}
