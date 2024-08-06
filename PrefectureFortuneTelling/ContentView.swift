//
//  ContentView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var year = 2_000
    @State private var month = 1
    @State private var day = 1
    @State private var bloodType = ""
    @State private var fortuneResponse: FortuneResponse?

    var body: some View {
        VStack {
            TextField("Name", text: $name)
            TextField("Year", value: $year, formatter: NumberFormatter())
            TextField("Month", value: $month, formatter: NumberFormatter())
            TextField("Day", value: $day, formatter: NumberFormatter())
            TextField("Blood Type", text: $bloodType)
            Button("Get Fortune") {
                let birthday = YearMonthDay(year: year, month: month, day: day)
                let today = YearMonthDay(year: 2_023, month: 5, day: 5)
                let request = FortuneRequest(name: name, birthday: birthday, bloodType: bloodType, today: today)

                API().fetchFortune(request: request) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.fortuneResponse = response
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            if let response = fortuneResponse {
                VStack {
                    Text("Name: \(response.name)")
                    Text("Capital: \(response.capital)")
                    if let citizenDay = response.citizenDay {
                        Text("Citizen Day: \(citizenDay.month)/\(citizenDay.day)")
                    }
                    Text("Has Coast Line: \(response.hasCoastLine ? "Yes" : "No")")
                    Text("Brief: \(response.brief)")
                    if let url = URL(string: response.logoURL) {
                        AsyncImage(url: url)
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
