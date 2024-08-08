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
                Text("CompatibilityTitle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: {
                    isShowingContentView = true
                }) {
                    Text("Start")
                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    isShowingPastResults = true
                }) {
                    Text("ViewPastResults")
                }
                .buttonStyle(MyButtonStyle())
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
