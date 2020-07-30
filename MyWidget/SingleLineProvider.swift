//
//  SingleLineProvider.swift
//  MyWidget
//
//  Created by vu.thanh.long on 7/14/20.
//

import WidgetKit
import SwiftUI
import Intents
import Shared

struct GameStatusEntry: TimelineEntry {
    let date: Date
    var gameStatus: String
}

struct SingleLineProvider: IntentTimelineProvider {
    typealias Intent = ConfigurationIntent
    typealias Entry = SimpleEntry

    func line(for configuration: ConfigurationIntent) -> Line {
        switch configuration.line {
        case .circle:
            return .circle
        case .district:
            return .district
        case .hammersmith:
            return .hammersmith
        case .jubilee:
            return .jubilee
        case .metropolitan:
            return .metropolitan
        case .northern:
            return .northern
        case .piccadilly:
            return .piccadilly
        case .victoria:
            return .victoria
        case .waterloo:
            return .waterloo
        default: return .bakerloo
        }
    }
    
    func snapshot(for configuration: ConfigurationIntent,
                  with context: Context,
                  completion: @escaping (SimpleEntry) -> ()) {
        let line = self.line(for: configuration)
        StatusService.getStatus(client: NetworkClient(), for: line) {
            let entry = SimpleEntry(date: Date(), line: line, updates: $0)
            completion(entry)
        }
    }
    
    func timeline(for configuration: ConfigurationIntent,
                  with context: Context,
                  completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let line = self.line(for: configuration)
        StatusService.getStatus(client: NetworkClient(), for: line) {
            let entry = SimpleEntry(date: Date(), line: line, updates: $0)
            let expiryDate = Calendar.current.date(byAdding: .minute, value: 2, to: Date()) ?? Date()
            let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
            completion(timeline)
        }
    }
    
//    func placeholder(with: Context) -> SimpleEntry {
//        <#code#>
//    }
}

struct SingleLinePlaceholderView : View {
    var body: some View {
        SingleLineStatusView(update: LineStatusUpdate(line: .bakerloo))
    }
}

struct SingleLineWidget: Widget {
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: "Single Line",
                            intent: ConfigurationIntent.self,
                            provider: SingleLineProvider(),
                            placeholder: SingleLinePlaceholderView()) { (entry) in
            ZStack {
                ZStack {
                    if let update = entry.updates.first {
                        SingleLineStatusView(update: update)
                    } else {
                        SingleLinePlaceholderView()
                    }
                }
            }
        }
        .configurationDisplayName("Line Status")
        .description("See the status for a specific London Underground line")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// reload widget: kind same when create widget
// WidgetCenter.shared.reloadTimelines(ofKind: "com.mygame.character-detail")
// reload all widget
// WidgetCenter.shared.reloadAllTimelines()


