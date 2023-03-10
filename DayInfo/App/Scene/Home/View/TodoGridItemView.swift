//
//  TodoGridItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import SwiftUI
import WidgetKit

struct TodoGridItemView: View {
    
    @State var task = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var todo: Todo
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: todo.done ? "checkmark.circle" : "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.init(hex: todo.color ?? "#000000"))
                .padding(.leading, 12)
                .onTapGesture {
                    todo.done.toggle()
                    WidgetCenter.shared.reloadAllTimelines()
                    try? self.viewContext.save()
                    feedback.impactOccurred()
                }
            
            VStack(alignment: .center, spacing: 8) {
                Text(todo.title ?? "")
                    .strikethrough(todo.done, color: .init(hex: todo.color ?? "#000000"))
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(calculateDate(date: todo.date ?? Date()))
                    .font(.system(size: 15, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(width: gridSize/3*2, height: gridSize/3*2)
        }
        .padding()
        .frame(width: gridSize, height: gridSize / 2)
        .background(Color.white.cornerRadius(12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.init(hex: todo.color ?? "#000000"), lineWidth: 3))
    }
}

//struct TodoGridItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoGridItemView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
