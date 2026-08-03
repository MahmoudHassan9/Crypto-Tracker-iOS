//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import Foundation

/*
 curl --request GET \
   --url 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h' \
   --header 'x-cg-demo-api-key: CG-L21aEybKhwef4zUdKATd832N'
 */

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinModel = try? JSONDecoder().decode(CoinModel.self, from: jsonData)

// MARK: - CoinMode
struct CoinModel: Identifiable, Codable, Hashable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap: Double?
    let marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24H: Double?
    let low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHolding: Double?

    func updateHoldings(with price: Double) -> CoinModel {
        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24H: high24H,
            low24H: low24H,
            priceChange24H: priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency:
                priceChangePercentage24HInCurrency,
            currentHolding: price,
        )
    }
    var currentHoldingsValue: Double {
        return (currentHolding ?? 0) * (currentPrice ?? 0)
    }

    var rank: Int {
        return Int(marketCapRank ?? 0)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath = "ath"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency =
            "price_change_percentage_24h_in_currency"
        case currentHolding
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable, Hashable {
    let price: [Double]?

    enum CodingKeys: String, CodingKey {
        case price = "price"
    }
}

extension CoinModel {
    static let fakeCoin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 100_000,
        marketCap: 2_000_000_000_000,
        marketCapRank: 1,
        fullyDilutedValuation: 2_100_000_000_000,
        totalVolume: 35_000_000_000,
        high24H: 101_500,
        low24H: 98_500,
        priceChange24H: 1_500,
        priceChangePercentage24H: 1.52,
        marketCapChange24H: 25_000_000_000,
        marketCapChangePercentage24H: 1.27,
        circulatingSupply: 19_900_000,
        totalSupply: 21_000_000,
        maxSupply: 21_000_000,
        ath: 109_114,
        athChangePercentage: -8.35,
        athDate: "2025-01-20T00:00:00.000Z",
        atl: 67.81,
        atlChangePercentage: 147300.5,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2026-07-28T12:00:00.000Z",
        sparklineIn7D: SparklineIn7D(
            price: [
                98000, 98500, 99000, 99500,
                100000, 100500, 101000, 100500,
                100000, 99500, 100200, 100000,
            ]
        ),
        priceChangePercentage24HInCurrency: 1.52,
        currentHolding: 10
    )
}
