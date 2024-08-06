//
//  FortuneResponse.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/05.
//


struct FortuneResponse: Codable {
    var name: String
    var capital: String
    var citizenDay: MonthDay?
    var hasCoastLine: Bool
    var logoURL: String
    var brief: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case citizenDay = "citizen_day"
        case hasCoastLine = "has_coast_line"
        case logoURL = "logo_url"
        case brief
    }
}

struct MonthDay: Codable {
    var month: Int
    var day: Int
}
