//
//  ColorGridView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct ColorGridView: View {
    
    @Environment(\.managedObjectContext) var contextView
    @ObservedObject var todo: Todo
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
            ForEach(basicColor, id: \.self) { colorString in
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.init(hex: colorString))
                    .onTapGesture {
                        todo.color = colorString
                        try? self.contextView.save()
                    }
            }
        }
        .frame(height: 35)
    }
}

//struct ColorGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorGridView(todo: sampleTodo)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
