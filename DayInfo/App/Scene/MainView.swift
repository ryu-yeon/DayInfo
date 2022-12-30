//
//  MainView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("일정")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
