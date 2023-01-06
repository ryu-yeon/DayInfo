//
//  TodoDetailView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI

struct TodoDetailView: View {
    
    @State private var title = ""
    @State private var description = ""
    @State private var isEditMode = false
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var contextView
    
    @State private var date = Date()
    
    @ObservedObject var item: Item
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if isEditMode {
                HStack {
                    ColorGridView(item: item)
                    
                    Spacer()
                    
                    DatePicker(selection: $date, displayedComponents: .date) {

                    }
                    .onChange(of: date) { newValue in
                        item.date = date
                        try? self.contextView.save()
                    }
                }
            }
            
            HStack{
                TextField("할 일을 입력해주세요.", text: $title)
                    .background(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                    )
                    .onChange(of: title) { newValue in
                        item.title = newValue
                        try? self.contextView.save()
                    }
                
                Image(systemName: item.done ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: item.color ?? "#000000"))
                    .onTapGesture {
                        withAnimation {
                            item.done.toggle()
                            try? self.contextView.save()
                            feedback.impactOccurred()
                        }
                    }
            }

            TextEditor(text: $description)
                .background(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 2)
                )
                .onChange(of: description) { newValue in
                    item.content = newValue
                    try? self.contextView.save()
                }
        }
        .onAppear {
            title = item.title ?? ""
            description = item.content ?? ""
            date = item.date ?? Date()
        }
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
                    self.contextView.delete(item)
                    try? self.contextView.save()
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("삭제")
                }
                
                Button {
                    withAnimation {
                        isEditMode = false
                    }
                } label: {
                    Text("완료")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.black)
    }
}

//struct TodoDetailView_Previews: PreviewProvider {
//    @Environment(\.managedObjectContext) var contextView
//    static var item = Item(context: contextView
//
//    static var previews: some View {
//        NavigationView {
//            TodoDetailView(item: item)
//        }
//    }
//}
