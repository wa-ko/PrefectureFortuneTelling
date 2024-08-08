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
                    Text("User \(result.user)")
                        .font(.headline)
                    Text("Result \(result.name)")
                        .font(.subheadline)
                    Text("Date \(result.date, formatter: dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .onDelete(perform: deleteResults)
        }
        .navigationTitle("PastResultsTitle")
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
