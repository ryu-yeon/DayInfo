//
//  HomeView.swift
//  DayInfo
//
//  Created by 유연탁 on 2022/12/30.
//

import SwiftUI

import Combine
import WidgetKit

struct HomeView: View {
    // MARK: - PROPERTIES
    @AppStorage("isList") var isList = true
    @State private var selectedIndex = -1
    @State private var showAlert = false
    
    @ObservedObject var viewModel = HomeViewModel()
    @State var isFilter = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        animation: .default) private var todos: FetchedResults<Todo>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        predicate: NSPredicate(format: "done == NO"),
        animation: .default) private var todoList: FetchedResults<Todo>
    
    
    private func addTodo() {
        withAnimation {
            let newItem = Todo(context: viewContext)
            newItem.date = Date()
            newItem.title = ""
            newItem.content = ""
            newItem.color = ""
            newItem.done = false
            newItem.id = UUID()
            newItem.color = "#000000"

            do {
                try viewContext.save()
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteTodos(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
                WidgetCenter.shared.reloadAllTimelines()
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
                            ForEach (isFilter ? todoList : todos) { todo in
                                NavigationLink {
                                    TodoDetailView(todo: todo)
                                } label: {
                                    TodoItemView(todo: todo)
                                }
                            }
                            .onDelete(perform: deleteTodos)
                        }
                        .listStyle(.plain)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 20) {
                                ForEach(isFilter ? todoList : todos) { todo in
                                    NavigationLink {
                                        TodoDetailView(todo: todo)
                                    } label: {
                                        TodoGridItemView(todo: todo)
                                            .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
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
                        .foregroundColor(Color.gray)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        )
                        .padding(10)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 3, y: 4)
                        .padding(.trailing, 8)
                })
            }    
            .navigationBarTitle("심플한 투두", displayMode: .inline)
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
        .accentColor(.black)
    }
}



// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
