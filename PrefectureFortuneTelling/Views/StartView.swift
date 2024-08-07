//
//  StartView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/07.
//

import SwiftUI

struct StartView: View {
    @State private var isShowingContentView = false
    @State private var isShowingPastResults = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("あなたと相性のいい都道府県を占ってあげる！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: {
                    isShowingContentView = true
                }) {
                    Text("スタート")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(8)
                }

                Button(action: {
                    isShowingPastResults = true
                }) {
                    Text("過去の占い結果を見る")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(8)
                }
            }
            .navigationDestination(isPresented: $isShowingContentView) {
                ContentView()
            }
            .navigationDestination(isPresented: $isShowingPastResults) {
                PastResultsView()
            }
        }
    }
}

#Preview {
    StartView()
}
