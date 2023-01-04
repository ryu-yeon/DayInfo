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
    @ObservedObject var viewModel = HomeViewModel()
    @State var isList = true
    
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
                        List(viewModel.todoList) { todo in
                            NavigationLink {
                                TodoDetailView(todo: todo)
                            } label: {
                                TodoItemView(todo: todo)
                            }
                        }
                        .listStyle(.plain)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 20) {
                                ForEach(viewModel.todoList) { todo in
                                    NavigationLink {
                                        TodoDetailView(todo: todo)
                                    } label: {
                                        TodoGridItemView(todo: todo)
                                            .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
                
                NavigationLink(destination: {
                    TodoDetailView(todo: sampleTodo)
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
                viewModel.fetchTodo()
            }
            .navigationBarTitle("HOME", displayMode: .large)
            .toolbar {
                HStack {
                    Button {
                        isList.toggle()
                    } label: {
                        Image(systemName: isList ? "square.grid.2x2" : "square.fill.text.grid.1x2")
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
