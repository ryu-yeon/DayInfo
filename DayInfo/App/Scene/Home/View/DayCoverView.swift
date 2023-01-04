//
//  DayCoverView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct DayCoverView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
            VStack(alignment: .center, spacing: 8) {
                <#code#>
            }
        }
    }
}

struct DayCoverView_Previews: PreviewProvider {
    static var previews: some View {
        DayCoverView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
