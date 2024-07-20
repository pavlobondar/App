//
//  Weather.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct Weather: Decodable {
    let location: Location
    let current: Current
    let forecast: [Forecast]
    
    var region: String {
        return "\(location.country)"
    }
    
    var city: String {
        return location.name
    }
    
    var temp: String {
        return "\(current.tempC)°"
    }
    
    var description: String {
        return current.condition.text
    }
    
    var detailInfo: [AdditionalInfo] {
        return [
            .humidity(humidity: current.humidity),
            .windMph(windMph: current.windMph),
            .feelslikeC(feelslikeC: current.feelslikeC)
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
    
    enum ForecastCodingKeys: String, CodingKey {
        case forecastday = "forecastday"
    }
    
    init(location: Location,
         current: Current,
         forecast: [Forecast]) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try container.decode(Location.self, forKey: .location)
        current = try container.decode(Current.self, forKey: .current)
        
        let forecastInfo = try container.nestedContainer(keyedBy: ForecastCodingKeys.self, forKey: .forecast)
        forecast = try forecastInfo.decode([Forecast].self, forKey: .forecastday)
    }
}

extension Weather {
    static func makeDefault() -> Weather {
        return Weather(
            location: .makeDefault(),
            current: .makeDefault(),
            forecast: [
                .makeDefault(),
                .makeDefault(),
                .makeDefault()
            ]
        )
    }
}
