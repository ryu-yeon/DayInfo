//
//  TodoGridItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import SwiftUI

struct TodoGridItemView: View {
    
    @State var task = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: item.done ? "checkmark.circle" : "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.init(hex: item.color ?? "#000000"))
                .padding(.leading, 12)
                .onTapGesture {
                    item.done.toggle()
                    try? self.viewContext.save()
                    feedback.impactOccurred()
                }
            
            VStack(alignment: .center, spacing: 8) {
                Text(item.title ?? "")
                    .strikethrough(item.done, color: .init(hex: item.color ?? "#000000"))
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(calculateDate(date: item.date ?? Date()))
                    .font(.system(size: 15, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(width: gridSize/3*2, height: gridSize/3*2)
        }
        .padding()
        .frame(width: gridSize, height: gridSize / 2)
        .background(Color.white.cornerRadius(12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.init(hex: item.color ?? "#000000"), lineWidth: 3))
    }
}

//struct TodoGridItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoGridItemView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
