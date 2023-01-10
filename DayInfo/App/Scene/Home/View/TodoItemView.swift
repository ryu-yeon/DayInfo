//
//  TodoItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI
import WidgetKit

struct TodoItemView: View {
        
    @Environment (\.managedObjectContext) var viewContext
    @ObservedObject var todo: Todo
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: todo.done ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: todo.color ?? "#000000"))
                    .offset(y: 4)
                    .onTapGesture {
                        todo.done.toggle()
                        try? self.viewContext.save()
                        WidgetCenter.shared.reloadAllTimelines()
                        feedback.impactOccurred()
                    }
                
                Text(calculateDate(date: todo.date ?? Date()))
                    .font(.system(size: 12, design: .rounded))
                    .frame(maxWidth: 60)
            }
            
            VStack(alignment: .leading, spacing: 8) {
    
                Text(todo.title ?? "")
                    .strikethrough(todo.done, color: .init(hex: todo.color ?? "#000000"))
                    .font(.headline)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(todo.content ?? "")
                    .font(.footnote)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
    }
}

//struct TodoItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemView(item: <#Item#>)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
