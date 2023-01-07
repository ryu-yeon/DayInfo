//
//  WeatherAPIService.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import Foundation

import Moya
import Combine

final class WeatherAPIService {
    
    let locationHelper = LocationHelper()
    let pass = PassthroughSubject<Weather, Never>()
    var cancellabel = Set<AnyCancellable>()
    
    init() {
        requestWeather()
    }
    
    func requestWeather() {
        let provider = MoyaProvider<WeatherAPI>()
        locationHelper.pass
            .sink { (latitude, longitude) in
                provider.request(.weatherInfo(lat: latitude, lon: longitude)) { response in
                    switch response {
                    case .success(let result):
                        guard let data = try? result.map(Weather.self) else { return }
                        self.pass.send(data)
                    case .failure(let error):
                        print("ERROR: ", error)
                    }
                }
            }
            .store(in: &cancellabel)
    }
}
