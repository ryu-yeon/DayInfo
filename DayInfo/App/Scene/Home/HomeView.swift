//
//  HomeView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

import Combine

struct HomeView: View {
    // MARK: - PROPERTIES
    @AppStorage("isList") var isList = true
    
    @ObservedObject var viewModel = HomeViewModel()
    @State var isFilter = false
    @State var todoList: [Item] = []
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.date = Date()
            newItem.title = ""
            newItem.content = ""
            newItem.color = ""
            newItem.done = false
            newItem.id = UUID()
            newItem.color = "#000000"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center, spacing: 8) {
                    
                    if let weather = viewModel.weather {
                        CoverView(weather: weather)
                    } else {
                        EmptyView()
                    }
                    
                    Spacer()
                    HStack(alignment: .center, spacing: 8) {
                        Spacer()
                        
                        Button {
                            if isFilter {
                                todoList = Array(items)
                            } else {
                                todoList = Array(items).filter{$0.done == false}
                            }
                            isFilter.toggle()
                        } label: {
                            Text(isFilter ? "모두 보기" : "미완료 보기")
                                .font(.footnote)
                                .padding(4)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray ,lineWidth: 3))
                        }
                        
                        Button {
                            isList.toggle()
                        } label: {
                            Image(systemName: isList ? "square.grid.2x2" : "square.fill.text.grid.1x2")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 16)
                    }
                    
                    if isList {
                        List {
                            ForEach (todoList) { item in
                                NavigationLink {
                                    TodoDetailView(item: item)
                                } label: {
                                    TodoItemView(item: item)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .listStyle(.plain)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 20) {
                                ForEach(todoList) { item in
                                    NavigationLink {
                                        TodoDetailView(item: item)
                                    } label: {
                                        TodoGridItemView(item: item)
                                            .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
//                                            .onLongPressGesture {
//                                                guard let index = items.firstIndex(of: item) else { return }
//                                                deleteItems(offsets: IndexSet(integer: index))
                                    }
                                }
                                
                            }
                            .padding()
                        }
                    }
                }
                
                NavigationLink(destination: {
                    AddTodoView()
                        .environment(\.managedObjectContext, self.viewContext)
                }, label: {
                    Circle()
                        .foregroundColor(Color.yellow)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        )
                        .padding(10)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 3, y: 4)
                })
            }    
            .navigationBarTitle("HOME", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "person.circle")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear {
            todoList = Array(items)
        }
        .accentColor(.black)
    }
}



// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
