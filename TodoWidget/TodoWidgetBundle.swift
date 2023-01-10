//
//  TodoWidgetBundle.swift
//  TodoWidget
//
//  Created by 유연탁 on 2023/01/09.
//

import WidgetKit
import SwiftUI

@main
struct TodoWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoWidget()
        TodoWidgetLiveActivity()
    }
}
