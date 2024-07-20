//
//  StorageService.swift
//  WApp
//
//  Created by Pavlo on 20.07.2024.
//

import Foundation

final class StorageService {
    
    enum StorageKeys {
        case query
        
        var key: String {
            switch self {
            case .query:
                return "queryKey"
            }
        }
        
        var value: String {
            switch self {
            case .query:
                return "Kyiv"
            }
        }
    }
    
    private let storage: UserDefaults
    
    static let shared = StorageService()
    
    private init() {
        storage = UserDefaults(suiteName: "group.com.bondar.WApp") ?? .standard
        registerDefaults()
    }
    
    private func registerDefaults() {
        storage.register(defaults: [
            StorageKeys.query.key: StorageKeys.query.value
        ])
    }
    
    func saveQuery(_ query: String) {
        storage.set(query, forKey: StorageKeys.query.key)
    }
    
    func getQuery() -> String {
        storage.string(forKey: StorageKeys.query.key) ?? StorageKeys.query.value
    }
}
