//
//  WeatherViewModel.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import Foundation
import Combine
import WidgetKit

class WeatherViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable>
    private var storage: StorageService
    
    @Published var weather: Weather
    @Published var query: String
    
    init() {
        self.cancellables = []
        self.storage = StorageService.shared
        self.weather = .makeDefault()
        self.query = StorageService.shared.getQuery()
        
        $query
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { query in
                return !query.isEmpty
            }
            .filter { isValid in
                return isValid
            }
            .sink { [weak self] _ in
                self?.fetchWeather()
            }
            .store(in: &cancellables)
    }
    
    private func fetchWeather() {
        NetworkService.shared.fetchForecast(city: query)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("Finished")
                }
            } receiveValue: { [weak self] weather in
                guard let self = self else { return }
                self.weather = weather
                self.storage.saveQuery(query)
                WidgetCenter.shared.reloadAllTimelines()
            }
            .store(in: &cancellables)
    }
}
