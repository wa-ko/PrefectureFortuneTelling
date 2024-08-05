//
//  ResponseBody.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/05.
//


struct ResponceBody: Codable {
    var name: String
    var capital: String
    var citizenDay: MonthDay?
    var hasCoastLine: Bool
    var logoUrl: String
    var brief: String
}

struct MonthDay: Codable {
    var month: Int
    var day: Int
}
