//
//  TodoWidget.swift
//  TodoWidget
//
//  Created by 유연탁 on 2023/01/09.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TodoWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        predicate: NSPredicate(format: "date >= %@", Date(timeIntervalSinceNow: -86400) as CVarArg),
        animation: .default) private var todos: FetchedResults<Todo>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        predicate: NSPredicate(format: "date >= %@ && done == NO", Date(timeIntervalSinceNow: -86400) as CVarArg),
        animation: .default) private var todList: FetchedResults<Todo>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        animation: .default) private var anniversaries: FetchedResults<Anniversary>
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    
    var body: some View {
        switch self.family {
        case .systemSmall:
            VStack(spacing: 4) {
                HStack {
                    Text("할 일 목록")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Text("\(todList.count)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 0)
                
                Divider()
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
                
                ForEach(0...3, id: \.self) { i in
                    if i < todos.count {
                        TodoItemWidgetView(todo: todos[i])
                    } else if i >= todos.count {
                        Text("")
                            .background(.gray)
                            .frame(height: 22)
                    }
                }
                
            }
            
        case .systemMedium:
            HStack(alignment: .center, spacing: 16) {
                if !anniversaries.isEmpty {
                    HStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .center, spacing: 8) {
                            Text(anniversaries[0].title ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(alignment: .center, spacing: 4) {
                                
                                if anniversaries[0].icon != "" {
                                    Image(systemName: anniversaries[0].icon ?? "")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.red)
                                }
                                
                                Text(calculateDate(date: anniversaries[0].date ?? Date()))
                                    .font(.headline)
                                    .fontWeight(.heavy)
                            }
                        }
                    }
                    .frame(width: 140, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
                    .padding(.leading, 24)
                } else {
                    Text("디데이를\n추가해주세요.")
                        .multilineTextAlignment(.center)
                        .frame(width: 140, height: 120)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray ,lineWidth: 3))
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 3, y: 2)
                        .padding(.leading, 24)
                }
                
                VStack(spacing: 4) {
                    HStack {
                        Text("할 일 목록")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        
                        Spacer()
                        
                        Text("\(todList.count)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    .padding(.bottom, 0)
                    
                    Divider()
                        .padding(.horizontal, 8)
                        .padding(.bottom, 4)
                    
                    ForEach(0...3, id: \.self) { i in
                        if i < todos.count {
                            TodoItemWidgetView(todo: todos[i])

                        } else if i >= todos.count {
                            Text("")
                                .background(.gray)
                                .frame(height: 22)
                        }
                    }
                    
                }
                .padding(.leading, 8)
                .padding(.trailing, 16)
            }
            
        case .systemLarge:
            Text("준비중입니다...")
            
        @unknown default:
            Text("준비중입니다...")
            
        }
    }
}

struct TodoWidget: Widget {
    let kind: String = "TodoWidget"
    let persistenceController = PersistenceController.shared


    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TodoWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodoWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
