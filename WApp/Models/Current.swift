//
//  Current.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct Current: Decodable {
    let tempC: Double
    let condition: Condition
    let feelslikeC: Double
    let humidity: Int
    let windMph: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition = "condition"
        case feelslikeC = "feelslike_c"
        case humidity = "humidity"
        case windMph = "wind_mph"
    }
}

extension Current {
    static func makeDefault() -> Current {
        return Current(
            tempC: 0.0,
            condition: .makeDefault(),
            feelslikeC: 0.0,
            humidity: 0,
            windMph: 0.0
        )
    }
}
