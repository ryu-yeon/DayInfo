//
//  DayView.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/01.
//

import SwiftUI
import PopupView

struct DayView: View {
    
    @State private var selectedIndex = -1
    @State private var showAlert = false
    @State private var showMakeAlert = false
    @State private var showPopup = false
    @State private var title = ""
    @State private var date = Date()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        animation: .default) private var anniversaries: FetchedResults<Anniversary>
    @Environment(\.managedObjectContext) private var viewContext
    
    private func addAnniversary() {
        withAnimation {
            let newItem = Anniversary(context: viewContext)
            newItem.title = "title"
            newItem.date = Date()
            newItem.icon = ""
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteAnniversary(offsets: IndexSet) {
        withAnimation {
            offsets.map { anniversaries[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func createAnniversary() -> some View {
        VStack {
            
            Text("디데이 추가")
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            HStack {
                TextField("제목을 입력해주세요.", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 160)
                
                DatePicker(selection: $date, displayedComponents: .date){
                    
                }
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 20) {
                Button {
                    showMakeAlert = false
                } label: {
                    Text("취소")
                        .foregroundColor(.black)
                }
                .frame(width: 120, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                
                Button {
                    if title == "" {
                        showPopup = true
                    } else {
                        let newItem = Anniversary(context: viewContext)
                        newItem.title = title
                        newItem.date = date
                        newItem.icon = ""
                        try? self.viewContext.save()
                        showMakeAlert = false
                    }
                } label: {
                    Text("저장")
                        .foregroundColor(.black)
                }
                .frame(width: 120, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                .popup(isPresented: $showPopup, type: .floater(verticalPadding: 20), position: .top, animation: .spring(), autohideIn: 1, closeOnTap: true, closeOnTapOutside: true, view: {
                    
                    Text("제목을 입력해주세요.")
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                })
            }

        }
        .padding()
        .frame(width: 320, height: 150)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
     }
    
    func deletPopup() -> some View {
        VStack {
            Text("삭제하시겠습니까?")
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 20) {
                Button {
                    showAlert = false
                } label: {
                    Text("취소")
                        .foregroundColor(.black)
                }
                .frame(width: 90, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                
                Button {
                    deleteAnniversary(offsets: IndexSet(integer: selectedIndex))
                    showAlert = false
                } label: {
                    Text("삭제")
                        .foregroundColor(.red)
                }
                .frame(width: 90, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
            }
        }
        .padding()
        .frame(width: 250, height: 120)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
     }
    
    var body: some View {
        
        if anniversaries.isEmpty {
            Button {
                showMakeAlert = true
                
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
            .popup(isPresented: $showMakeAlert, type: .default, position: .bottom, animation: .spring(), closeOnTap: false, closeOnTapOutside: false, view: {
                self.createAnniversary()
            })
            
        } else {
            TabView {
                ForEach(anniversaries) { anniversary in
                    VStack(alignment: .center, spacing: 8) {
                        Text(anniversary.title ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                        HStack(alignment: .center, spacing: 4) {
                            
                            if anniversary.icon != "" {
                                Image(systemName: anniversary.icon ?? "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.red)
                            }
                            
                            Text(calculateDate(date: anniversary.date ?? Date()))
                                .font(.headline)
                                .fontWeight(.heavy)
                        }
                    }
                    .onLongPressGesture(perform: {
                        guard let index = anniversaries.firstIndex(of: anniversary) else { return }
                        selectedIndex = index
                        showAlert = true
                    })
                    .popup(isPresented: $showAlert, type: .default, position: .bottom, animation: .spring(), closeOnTap: false, closeOnTapOutside: false, view: {
                        self.deletPopup()
                    })
                }
                
                Button {
                    showMakeAlert = true
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                }
                .padding()
                .popup(isPresented: $showMakeAlert, type: .default, position: .bottom, animation: .spring(), closeOnTap: false, closeOnTapOutside: false, view: {
                    self.createAnniversary()
                })
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
