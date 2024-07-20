//
//  AppIntent.swift
//  WeatherWidget
//
//  Created by Pavlo on 18.07.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")
}
