//
//  SettingView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/07.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            GroupBox(
                label:
                    SettingLabelView(labelText: "DayInfo", labelImage: "info.circle")
            ) {
                Divider().padding(.vertical, 4)
                
                HStack(alignment: .center, spacing: 10) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(9)
                    
                    Text("심플한 디자인의 할일 목록 앱입니다.\n상단에서 현재위치의 날씨와 설정한 디데이를 볼수 있습니다. 할일 목록을 추가하고 색상, 목표일을 지정할수 있습니다.")
                        .font(.footnote)
                }
                
            }
            .padding()
            
            GroupBox(
                label: SettingLabelView(labelText: "Application", labelImage: "iphone.circle")
            ) {
                SettingRowView(name: "Developer", content: "yeontak ryu")
                SettingRowView(name: "Compatibility", content: "iOS 16")
                SettingRowView(name: "SwiftUI", content: "2.0")
                SettingRowView(name: "Version", content: "1.0")
                Divider()
                Text("Copyright 2023. yeontak ryu all rights reserved.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }
            .padding()

            
            Spacer()
            
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
