//
//  HTTPBody.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/04.
//


struct HTTPBody: Codable {
    var name: String
    var birthday: YearMonthDay
    var bloodType: String
    var today: YearMonthDay
}

struct YearMonthDay: Codable {
    var year: Int
    var mounth: Int
    var day: Int
}
