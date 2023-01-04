//
//  TodoGridItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/05.
//

import SwiftUI

struct TodoGridItemView: View {
    
    @State var task = false
    let todo: Todo
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: task ? "checkmark.\(todo.icon)" : todo.icon)
                .scaledToFit()
                .imageScale(.large)
                .foregroundColor(Color.init(hex: todo.color))
                .onTapGesture {
                    task.toggle()
                    TodoRepository.shared.updateDone(task, todo: todo)
                }
            
            VStack(alignment: .center, spacing: 8) {
                Text(todo.title)
                    .strikethrough(todo.done, color: .init(hex: todo.color))
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text("D-5")
                    .font(.system(size: 15, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(width: gridSize/3*2, height: gridSize/3*2)
        }
        .padding()
        .frame(width: gridSize, height: gridSize / 2)
        .background(Color.white.cornerRadius(12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.init(hex: todo.color), lineWidth: 3))
        .onAppear {
            task = todo.done
        }
    }
}

struct TodoGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoGridItemView(todo: sampleTodo)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
