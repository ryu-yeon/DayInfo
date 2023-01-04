//
//  WeatherAPI.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import Foundation

import Moya

enum WeatherAPI {
    case weatherInfo
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .weatherInfo:
            return URL(string: "https://api.openweathermap.org")!
        }
    }
    
    var path: String {
        switch self {
        case .weatherInfo:
            return "/data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weatherInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .weatherInfo:
            let parameters: [String: Any] = [
                "lat": 37.498454033368,
                "lon": 127.03229336072,
                "appid": apikey,
                "lang": "kr",
                "units": "metric"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .weatherInfo:
            return nil
        }
    }
}

