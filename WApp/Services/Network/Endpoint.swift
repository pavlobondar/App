//
//  Endpoint.swift
//  WApp
//
//  Created by Pavlo on 18.07.2024.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func weather(query: String) -> Endpoint {
        return .init(
            path: "/v1/forecast.json",
            queryItems: [
                .init(name: "q", value: query),
                .init(name: "days", value: "7"),
                .init(name: "key", value: "522db6a157a748e2996212343221502")
            ]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.weatherapi.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
