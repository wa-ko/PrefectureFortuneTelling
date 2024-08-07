//
//  ResultView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/07.
//
import SwiftUI

struct ResultView: View {
    @Binding var fortuneResponse: FortuneResponse?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let response = fortuneResponse {
                VStack(alignment: .leading, spacing: 10) {
                    Text("あなたと相性のいい都道府県は…")
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
                Text("県庁所在地: \(response.capital)")
                    .font(.title2)
                    .padding(.top, 10)
                if let citizenDay = response.citizenDay {
                    Text("県民の日: \(citizenDay.month)/\(citizenDay.day)")
                        .font(.title3)
                }
                Text("海岸線: \(response.hasCoastLine ? "あり" : "なし")")
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
            } else {
                Text("データを取得できませんでした")
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
    }
}
