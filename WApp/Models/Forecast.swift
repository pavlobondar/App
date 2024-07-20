//
//  Forecast.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct Forecast: Decodable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    
    let date: String
    let day: ForecastDay
    
    var maxtempC: String {
        return "\(day.maxtempC)°"
    }
    
    var mintempC: String {
        return "\(day.mintempC)°"
    }
    
    var temp: String {
        let temp = (day.maxtempC + day.mintempC) / 2
        return String(format: "%.0f°", temp)
    }
    
    var overview: String {
        return day.condition.text
    }
    
    var dayDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? Date()
    }
    
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: dayDate)
    }
}

extension Forecast {
    static func makeDefault() -> Forecast {
        return Forecast(
            date: "2021-02-21 08:30",
            day: .init(maxtempC: 0.0, mintempC: 0.0, condition: .makeDefault())
        )
    }
}
