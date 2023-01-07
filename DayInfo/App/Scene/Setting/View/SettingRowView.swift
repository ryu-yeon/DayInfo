//
//  SettingRowView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/07.
//

import SwiftUI

struct SettingRowView: View {
    var name: String
    var content: String? = nil
    var lineLabel: String? = nil
    var linkDestination: String? = nil
    
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack {
                Text(name).foregroundColor(.gray)
                Spacer()
                if content != nil {
                    Text(content!)
                } else if lineLabel != nil && linkDestination != nil {
                    Link(lineLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.pink)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

//struct SettingRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingRowView()
//    }
//}
