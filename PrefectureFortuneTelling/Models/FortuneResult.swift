//
//  FortuneResult.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/07.
//

import Foundation
import SwiftData

@Model
class FortuneResult: Identifiable {
    var id: UUID = UUID()
    var user: String
    var name: String
    var date: Date

    init(user: String, name: String, date: Date = Date()) {
        self.user = user
        self.name = name
        self.date = date
    }
}
