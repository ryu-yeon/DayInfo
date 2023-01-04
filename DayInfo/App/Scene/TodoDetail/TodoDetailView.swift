//
//  TodoDetailView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct TodoDetailView: View {
    
    @State private var title = "안녕하세요"
    @State private var description = ""
    @State private var task = false
    @State private var isEditMode = false
    @Environment(\.presentationMode) var presentation
    
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if isEditMode {
                HStack {
                    ColorGridView(todo: todo)
                    Spacer()
                }
            }
            
            HStack{
                TextField(todo.title, text: $title)
                    .background(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                    )
                Image(systemName: task ? "checkmark.\(todo.icon)" : todo.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: todo.color))
                    .onTapGesture {
                        withAnimation {
                            task.toggle()
                            TodoRepository.shared.updateDone(task, todo: todo)
                        }
                    }
            }
            
            TextEditor(text: $description)
                .background(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                )
        }
        .onAppear(perform: {
            task = todo.done
        })
        .padding()
        .toolbar {
            if !isEditMode {
                Button {
                    withAnimation {
                        isEditMode = true
                    }
                } label: {
                    Text("편집")
                }
            } else {
                Button {
                    TodoRepository.shared.deleteTodo(todo: todo)
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("삭제")
                }
                
                Button {
                    let todo = Todo(title: title, detail: description, date: "", color: "", icon: "circle", done: false)
                    TodoRepository.shared.addTodo(todo: todo)
                    withAnimation {
                        isEditMode = false
                    }
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("저장")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoDetailView(todo: sampleTodo)
        }
    }
}
