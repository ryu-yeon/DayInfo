//
//  DayView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct DayView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("수능")
                .font(.title)
                .fontWeight(.bold)
            HStack(alignment: .center, spacing: 4) {
    
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
                
                Text("D-29")
                    .font(.headline)
                    .fontWeight(.heavy)
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
