//
//  SettingLabelView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/07.
//

import SwiftUI

struct SettingLabelView: View {
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingLabelView(labelText: "DayInfo", labelImage: "heart")
    }
}
