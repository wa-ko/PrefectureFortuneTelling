//
//  PastResultsView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/07.
//

import SwiftData
import SwiftUI

struct PastResultsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FortuneResult.date, order: .reverse) var results: [FortuneResult]

    var body: some View {
        List {
            ForEach(results) { result in
                VStack(alignment: .leading) {
                    Text("ユーザー: \(result.user)")
                        .font(.headline)
                    Text("占った結果: \(result.name)")
                        .font(.subheadline)
                    Text("日付: \(result.date, formatter: dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .onDelete(perform: deleteResults)
        }
        .navigationTitle("過去の占い結果")
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }

    private func deleteResults(at offsets: IndexSet) {
        for index in offsets {
            let resultToDelete = results[index]
            modelContext.delete(resultToDelete)
        }
        do {
            try modelContext.save()
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    PastResultsView()
}
