//
//  Constant.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

let sampleWeather = Weather(weather: [WeatherBasic(id: 803, main: "Clouds", description: "튼구름", icon: "04d")],
                            main: WeatherMain(temp: -8.27, feels_like: -12.47, temp_min: -7.22, temp_max: -13.51, pressure: 1033, humidity: 53))

let gridSize = (UIScreen.main.bounds.width - 60) / 2

let basicColor = [
    "#FF0000", "#008000", "#0000FF", "#FFA500", "#808080", "#000000"
]

let feedback = UIImpactFeedbackGenerator(style: .medium)

func calculateDate(date: Date) -> String {
    let interval = Date().timeIntervalSince(date)
    let days = Int(floor(interval / 86400))
    
    if days > 0 {
        return "D+\(days)"
    } else if days < 0 {
        return "D\(days)"
    } else {
        return "D-DAY"
    }
}

func checkIcon(id: Int) -> String {
    switch id {
    case 200...202, 230...232:
        return "cloud.bolt.rain"
    case 210...221:
        return "cloud.bolt"
    case 300...321:
        return "cloud.drizzle"
    case 500...504:
        return "cloud.rain"
    case 511:
        return "cloud.hail"
    case 520...531:
        return "cloud.heavyrain"
    case 600...602:
        return "cloud.snow"
    case 611...622:
        return "cloud.sleet"
    case 711 :
        return "smoke"
    case 721:
        return "sun.haze"
    case 731, 751, 761, 762:
        return "sun.dust"
    case 771:
        return "wind"
    case 781:
        return "tornado"
    case 701, 741 :
        return "cloud.fog"
    case 800:
        return "sun.max"
    case 801 :
        return "cloud.sun"
    case 802...804:
        return "cloud"
    default:
        return "sun.min"
    }
}
