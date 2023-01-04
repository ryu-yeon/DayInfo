//
//  CoverView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct CoverView: View {
    
    var weather: Weather
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            WeatherView(weather: weather)
                .frame(width: 220, height: 130)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
            
            DayView()
                .frame(width: 120, height: 130)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
        }
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView(weather: sampleWeather)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
