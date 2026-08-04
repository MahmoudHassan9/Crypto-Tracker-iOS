//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 04/08/2026.
//

import Combine
import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {

    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let homeRepo: HomeRepoProtocol
    @Published var coin: CoinModel

    init(homeRepo: HomeRepoProtocol, coin: CoinModel) {
        self.homeRepo = homeRepo
        self.coin = coin
        getCoinDetails(for: coin.id)
    }

    private func getCoinDetails(for id: String?) {
        guard let id = id else {
            print("⚠️ coin.id is nil")
            return
        }
        isLoading = true
        homeRepo
            .getCoinDetails(id: id)
            .catch {
                [weak self] error -> AnyPublisher<CoinDetailModel, Never> in
                print("❌ getDetails failed: \(error)")
                self?.isLoading = false  // ← stop the spinner right here on failure
                return Empty().eraseToAnyPublisher()
            }
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink(
                receiveValue: { [weak self] (returnedArrays) in
                    self?.isLoading = false
                    self?.overviewStatistics = returnedArrays.overview
                    self?.additionalStatistics = returnedArrays.additional
                }
            )
            .store(in: &cancellables)

        homeRepo
            .getCoinDetails(id: id)
            .catch {
                error -> AnyPublisher<CoinDetailModel, Never> in
                print("❌ getDetails failed: \(error)")
                return Empty().eraseToAnyPublisher()
            }
            .sink(receiveValue: { [weak self] CoinDetailModel in
                self?.coinDescription = CoinDetailModel.readableDescription
                self?.websiteURL = CoinDetailModel.links?.homepage?.first
                self?.redditURL = CoinDetailModel.links?.subredditURL
            })
            .store(in: &cancellables)
    }

    private func mapDataToStatistics(
        coinDetailModel: CoinDetailModel?,
        coinModel: CoinModel
    ) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(
            coinDetailModel: coinDetailModel,
            coinModel: coinModel
        )
        return (overviewArray, additionalArray)
    }

    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice?.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(
            title: "Current Price",
            value: price ?? "",
            percentageChange: pricePercentChange
        )

        let marketCap =
            "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(
            title: "Market Capitalization",
            value: marketCap,
            percentageChange: marketCapPercentChange
        )

        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)

        let volume =
            "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)

        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat,
        ]
        return overviewArray
    }

    private func createAdditionalArray(
        coinDetailModel: CoinDetailModel?,
        coinModel: CoinModel
    ) -> [StatisticModel] {

        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)

        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)

        let priceChange =
            coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(
            title: "24h Price Change",
            value: priceChange,
            percentageChange: pricePercentChange
        )

        let marketCapChange =
            "$"
            + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(
            title: "24h Market Cap Change",
            value: marketCapChange,
            percentageChange: marketCapPercentChange
        )

        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(
            title: "Block Time",
            value: blockTimeString
        )

        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(
            title: "Hashing Algorithm",
            value: hashing
        )

        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat,
            hashingStat,
        ]
        return additionalArray
    }
}
