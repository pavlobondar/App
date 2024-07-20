//
//  ForecastDay.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct ForecastDay: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition = "condition"
    }
}
