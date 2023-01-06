//
//  AddTodoView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/07.
//

import SwiftUI

struct AddTodoView: View {
    @State private var title = ""
    @State private var content = ""
    @State private var task = false
    @State private var isEditMode = false
    @State private var isAnimating = false
    @State private var color = "#000000"

    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var contextView
    
    @State private var date = Date()
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                    ForEach(basicColor, id: \.self) { colorString in
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.init(hex: colorString))
                            .onTapGesture {
                                color = colorString
                            }
                    }
                }
                .frame(height: 35)
                
                Spacer()
                
                DatePicker(selection: $date, displayedComponents: .date) {
                }
            }
        
            HStack{
                TextField("할 일을 입력해주세요.", text: $title)
                    .background(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                    )
                
                Image(systemName: task ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: color))
                    .onTapGesture {
                        withAnimation {
                            task.toggle()
                            feedback.impactOccurred()
                        }
                    }
            }

            TextEditor(text: $content)
                .background(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                )
        }
        .padding()
        .toolbar {
            Button {
                let newItem = Item(context: self.contextView)
                newItem.title = title
                newItem.content = content
                newItem.date = date
                newItem.color = color
                newItem.done = task
                newItem.id = UUID()
                try? self.contextView.save()
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("저장")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
