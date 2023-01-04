//
//  TodoItemView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

struct TodoItemView: View {
    
    @State private var task = false
    
    let todo: Todo
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: task ? "checkmark.\(todo.icon)" : todo.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: todo.color))
                    .offset(y: 4)
                    .onTapGesture {
                        task.toggle()
                        TodoRepository.shared.updateDone(task, todo: todo)
                    }
                
                Text("D-5")
                    .font(.system(size: 20, design: .rounded))
            }
            VStack(alignment: .leading, spacing: 8) {
    
                Text(todo.title)
                    .strikethrough(todo.done, color: .init(hex: todo.color))
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Text(todo.detail)
                    .font(.footnote)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
        .onAppear {
            task = todo.done
        }
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todo: sampleTodo)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
