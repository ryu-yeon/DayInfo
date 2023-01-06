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
                    
                    if isList {
                        List {
                            ForEach (items) { item in
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
                                ForEach(items) { item in
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
            .onAppear {
            }
            .navigationBarTitle("HOME", displayMode: .inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isList.toggle()
                    } label: {
                        Image(systemName: isList ? "square.grid.2x2" : "square.fill.text.grid.1x2")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}



// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
