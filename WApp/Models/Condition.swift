//
//  Condition.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation

struct Condition: Decodable {
    let text: String
    let code: Int
}

extension Condition {
    static func makeDefault() -> Condition {
        return Condition(
            text: "Cloudly",
            code: 1000
        )
    }
}
