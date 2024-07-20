//
//  Location.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

extension Location {
    static func makeDefault() -> Location {
        return Location(
            name: "Kyiv",
            region: "",
            country: "Ukraine",
            localtime: ""
        )
    }
}
