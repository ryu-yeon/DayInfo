//
//  HomeViewModel.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import Foundation

import Combine

final class HomeViewModel: ObservableObject {

    init() {
        fetchWeather()
    }
    
    let api = WeatherAPIService()
    var cancellable = Set<AnyCancellable>()
    
    @Published var weather: Weather? = nil

    func fetchWeather() {
        api.pass
            .sink { weather in
                self.weather = weather
            }
            .store(in: &cancellable)
    }
    
    
}
