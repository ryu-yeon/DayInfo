//
//  WeatherView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: Weather
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .center, spacing: 4) {
                Image(systemName: checkIcon(id: weather.weather[0].id, sunrise: weather.sys.sunrise, sunset: weather.sys.sunset))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                
                Text(String(format: "%.1f°C", weather.main.temp))
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.heavy)
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "thermometer.high")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    Text(String(format: "%.1f°C", weather.main.temp_max))
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(minWidth: 50, alignment: .trailing)
                        .padding(.trailing, 0)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "thermometer.low")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    Text(String(format: "%.1f°C", weather.main.temp_min))
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(minWidth: 50, alignment: .trailing)
                        .padding(.trailing, 0)
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: sampleWeather)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
