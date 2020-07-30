//
//  AllLinesProvider.swift
//  Shared
//
//  Created by vu.thanh.long on 7/15/20.
//

import Foundation
import Shared
import WidgetKit
import SwiftUI

struct AllLinesProvider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        StatusService.getStatus(client: NetworkClient()) { updates in
            let entry = SimpleEntry(date: Date(), line: nil, updates: updates)
            completion(entry)
        }
    }
    
    func timeline(with context: Context,
                  completion: @escaping (Timeline<Entry>) -> ()) {
        StatusService.getStatus(client: NetworkClient()) { updates in
            let entry = SimpleEntry(date: Date(), line: nil, updates: updates)
            let expiryDate = Calendar.current.date(byAdding: .minute, value: 2, to: Date())!
            let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let line: Line?
    let updates: [LineStatusUpdate]
}

struct AllLinesPlaceholderView: View {
    var body: some View {
        GeometryReader { metrics in
            ContentView(updates: Line.allCases.map {
                LineStatusUpdate(line: $0)
            },
            height: metrics.size.height)
        }
    }
}

struct AllLinesWidget: Widget {
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: "All Lines",
                            provider: AllLinesProvider(),
                            placeholder: AllLinesPlaceholderView()) { entry in
            GeometryReader { metrics in
                ContentView(updates: entry.updates, height: metrics.size.height)
            }
        }
        .configurationDisplayName("Tube Status")
        .description("See the status board for all London Underground lines")
        .supportedFamilies([.systemLarge])
    }
}
