//
//  ContentView.swift
//  WApp
//
//  Created by Pavlo on 15.05.2024.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    @FocusState private var isFieldActive: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 22) {
            Text(viewModel.weather.region)
                .font(.title.bold())
            
            VStack(spacing: 12) {
                TextField("Search", text: $viewModel.query)
                    .font(.system(size: 38, weight: .medium, design: .rounded))
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .selectionDisabled()
                    .focused($isFieldActive)
                    .submitLabel(.search)
                    .onSubmit {
                        isFieldActive.toggle()
                    }
                Text(viewModel.weather.temp)
                    .font(.system(size: 102, weight: .bold, design: .rounded))
                    .contentTransition(.numericText())
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text(viewModel.weather.description)
                    .foregroundColor(.gray)
                    .font(.system(size: 23, weight: .bold, design: .rounded))
            }
            
            HStack(spacing: 8) {
                ForEach(viewModel.weather.detailInfo, id: \.id) {
                    getAditionalInfoView(info: $0)
                }
            }
            .frame(maxHeight: 100)
            
            VStack(spacing: 12) {
                ForEach(viewModel.weather.forecast, id: \.id) {
                    getForecastInfoView($0)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func getAditionalInfoView(info: AdditionalInfo) -> some View {
        VStack(spacing: 8) {
            Image(systemName: info.icon)
                .font(.title)
            Text(info.title)
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.accentColor)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("aditionalInfoColor"))
                .shadow(radius: 5)
        }
    }
    
    private func getForecastInfoView(_ forecast: Forecast) -> some View {
        HStack(spacing: 6) {
            VStack(alignment: .leading) {
                Text(forecast.overview)
                    .font(.system(size: 16, weight: .medium))
                Text(forecast.dayDate, style: .date)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .regular))
            }
            .padding(.vertical, 5)
            
            Spacer()
            
            HStack(spacing: 10) {
                Image(systemName: "thermometer.sun")
                    .foregroundColor(.pink)
                Text(forecast.maxtempC)
                Image(systemName: "thermometer.snowflake")
                    .foregroundColor(.blue)
                Text(forecast.mintempC)
            }
            .font(.system(size: 16, weight: .medium))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("aditionalInfoColor"))
                .shadow(radius: 5)
        )
    }
}

#Preview {
    WeatherView()
}
