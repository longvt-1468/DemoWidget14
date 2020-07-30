//
//  WidgetBundle.swift
//  MyApp
//
//  Created by vu.thanh.long on 7/14/20.
//

import SwiftUI
import WidgetKit

@main
struct MyAppWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        AllLinesWidget()
        SingleLineWidget()
    }
}
