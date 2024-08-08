//
//  ResultView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/07.
//
import SwiftData
import SwiftUI

struct ResultView: View {
    @Binding var name: String
    @Binding var fortuneResponse: FortuneResponse?
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let response = fortuneResponse {
                VStack(alignment: .leading, spacing: 10) {
                    Text("CompatibilityResult \(name)")
                    Text(response.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    if let url = URL(string: response.logoURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 150)
                    }
                }
                Text("Capital \(response.capital)")
                    .font(.title2)
                    .padding(.top, 10)
                if let citizenDay = response.citizenDay {
                    Text("CitizenDay \(citizenDay.month)/\(citizenDay.day)")
                        .font(.title3)
                }
                Text("CoastLine \(response.hasCoastLine ? String(localized: "Available") : String(localized: "NotAvailable"))")
                    .font(.title3)
                VStack {
                    Text(response.brief)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                .padding(.top, 10)

                .onAppear {
                    addResult(response: response)
                }
            } else {
                Text("DataFetchError")
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()

    }

    private func addResult(response: FortuneResponse) {
        let newResult = FortuneResult(user: name, name: response.name)
        modelContext.insert(newResult)
        do {
            try modelContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ResultView(name: .constant("test"), fortuneResponse: .constant(nil))
}
