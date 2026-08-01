//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 31/07/2026.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }

    static var stat1 = StatisticModel(
        title: "stat1",
        value: "10",
    )

    static var stat2 = StatisticModel(
        title: "stat2",
        value: "10",
        percentageChange: 10
    )

    static var stat3 = StatisticModel(
        title: "stat3",
        value: "10",
        percentageChange: -1
    )

}
