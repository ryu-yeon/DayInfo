//
//  TodoItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

struct TodoItemView: View {
        
    @Environment (\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: item.done ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: item.color ?? "#000000"))
                    .offset(y: 4)
                    .onTapGesture {
                        item.done.toggle()
                        try? self.viewContext.save()
                        feedback.impactOccurred()
                    }
                
                Text(calculateDate(date: item.date ?? Date()))
                    .font(.system(size: 12, design: .rounded))
                    .frame(maxWidth: 60)
            }
            
            VStack(alignment: .leading, spacing: 8) {
    
                Text(item.title ?? "")
                    .strikethrough(item.done, color: .init(hex: item.color ?? "#000000"))
                    .font(.headline)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(item.content ?? "")
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
