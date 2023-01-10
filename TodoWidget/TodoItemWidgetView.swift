//
//  TodoItemWidgetView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/10.
//

import SwiftUI

struct TodoItemWidgetView: View {
    
    @ObservedObject var todo: Todo
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(spacing: 2) {
                Image(systemName: todo.done ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.init(hex: todo.color ?? "#000000"))
                    .fontWeight(.bold)
                
                Text(calculateDate(date: todo.date ?? Date()))
                    .font(.system(size: 8, weight: .light, design: .rounded))
                    .frame(minWidth: 30)
            }
            
            
            Text(todo.title ?? "")
                .strikethrough(todo.done, color: .init(hex: todo.color ?? "#000000"))
                .font(.system(size: 14, weight: .light, design: .rounded))
                .offset(y: -3)
                .frame(width: 100, alignment: .leading)
                .padding(.horizontal, 2)
                .lineLimit(1)
        }
        .padding(.leading, 8)
        .frame(height: 22)
    }
}

//struct TodoItemWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemWidgetView(todo: <#Todo#>)
//    }
//}
