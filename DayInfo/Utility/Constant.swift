//
//  Constant.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

let sampleWeather = Weather(weather: [WeatherBasic(id: 803, main: "Clouds", description: "튼구름", icon: "04d")],
                            main: WeatherMain(temp: -8.27, feels_like: -12.47, temp_min: -7.22, temp_max: -13.51, pressure: 1033, humidity: 53))
let sampleTodo = Todo(title: "장보기", detail: "라면, 양파, 고기", date: "", color: "", icon: "circle", done: false)

let gridSize = (UIScreen.main.bounds.width - 60) / 2

let basicColor = [
    "#FF0000", "#008000", "#0000FF", "#FFA500", "#808080", "#000000"
]
