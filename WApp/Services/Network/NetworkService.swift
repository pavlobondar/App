//
//  NetworkService.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation
import Combine

class NetworkService {
    
    static let shared = NetworkService()
    
    private let decoder: JSONDecoder
    
    private init() {
        decoder = JSONDecoder()
    }
    
    func fetchForecast(city: String) -> AnyPublisher<Weather, Error> {
        guard let url = Endpoint.weather(query: city).url else {
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Weather.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func fetchForecast(city: String) async throws -> Weather {
        guard let url = Endpoint.weather(query: city).url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(Weather.self, from: data)
    }
}
