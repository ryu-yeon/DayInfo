//
//  WeatherModel.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/31.
//

import Foundation

struct Weather: Codable {
    let weather: [WeatherBasic]
    let main: WeatherMain
}

struct WeatherBasic: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
