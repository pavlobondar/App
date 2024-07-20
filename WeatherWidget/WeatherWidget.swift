//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Pavlo on 18.07.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weather: .makeDefault())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), weather: .makeDefault())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate) ?? currentDate
        let city = StorageService.shared.getQuery()
        do {
            let weather = try await NetworkService.shared.fetchForecast(city: city)
            let entry = SimpleEntry(date: currentDate, weather: weather)
            let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
            return timeLine
        } catch {
            let entry = SimpleEntry(date: currentDate, weather: .makeDefault())
            let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
            return timeLine
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weather: Weather
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        default:
            mediumWidget
        }
    }
    
    var smallWidget: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(entry.weather.temp)
                .font(.system(size: 38, weight: .bold))
                .multilineTextAlignment(.leading)
            Text(entry.weather.description)
                .font(.system(size: 18, weight: .medium))
            
            Spacer()
            
            HStack {
                ForEach(entry.weather.forecast, id: \.id) { forecast in
                    getForecastCard(for: forecast)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    var mediumWidget: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 30.0) {
                VStack {
                    Text(entry.weather.location.country)
                        .fontWeight(.light)
                    Text(entry.weather.city)
                        .font(.title.bold())
                }
                Spacer()
                HStack {
                    ForEach(entry.weather.forecast, id: \.id) { forecast in
                        getForecastCard(for: forecast)
                    }
                }
            }

            Spacer()
            
            HStack(spacing: 8) {
                ForEach(entry.weather.detailInfo, id: \.id) {
                    getAditionalInfoView(info: $0)
                }
            }
        }
    }
    
    private func getAditionalInfoView(info: AdditionalInfo) -> some View {
        VStack(spacing: 8) {
            Image(systemName: info.icon)
                .font(.system(size: 14))
            Text(info.title)
                .font(.system(size: 12, weight: .bold))
        }
        .padding(.vertical, 7)
        .frame(maxWidth: .infinity)
        .foregroundColor(.accentColor)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        }
    }
    
    private func getForecastCard(for forecast: Forecast) -> some View {
        VStack(alignment: .leading) {
            Text(forecast.dayOfWeek)
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(Color.gray)
            Text(forecast.temp)
                .font(.system(size: 14, weight: .bold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"
    let provider: Provider = Provider()

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: provider) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemMedium) {
    WeatherWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .makeDefault())
}
