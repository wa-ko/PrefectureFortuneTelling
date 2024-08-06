//
//  FortuneRequest.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/04.
//


struct FortuneRequest: Codable {
    var name: String
    var birthday: YearMonthDay
    var bloodType: String
    var today: YearMonthDay
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case bloodType = "blood_type"
        case today
    }
}

struct YearMonthDay: Codable {
    var year: Int
    var month: Int
    var day: Int
}
