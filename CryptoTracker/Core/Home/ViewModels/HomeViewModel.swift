//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var coinsIsLoading: Bool = false
    @Published var statistics: [StatisticModel] = []
    @Published var allCoinsList: [CoinModel] = []
    @Published var portfolioCoinsList: [CoinModel] = []
    @Published var coinImages: [String: UIImage] = [:]
    @Published var loadingImageURLs: Set<String> = []
    @Published var searchText: String = ""
    @Published var filteredCoins: [CoinModel] = []
    private var cancellables: Set<AnyCancellable> = []

    private let homeRepo: HomeRepoProtocol

    init(
        homeRepo: HomeRepoProtocol
    ) {
        self.homeRepo = homeRepo
        addSubscribers()
    }

    func addSubscribers() {
        getCoins()
        observeSearch()
        getMarketStats()
    }

    func observeSearch() {
        $searchText
            .combineLatest($allCoinsList)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.filteredCoins = coins
            }
            .store(in: &cancellables)
    }

    func getMarketStats() {
        homeRepo.getMarketStats()
            .map(mapGlobalMarketData)
            .replaceError(with: [])
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }

    private func getCoins() {
        coinsIsLoading = true
        homeRepo
            .getCoins()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.coinsIsLoading = false
                },
                receiveValue: { [weak self] coins in
                    self?.allCoinsList = coins
                    self?.filteredCoins = coins
                }
            )
            .store(in: &cancellables)
    }

    func getCoinImage(for url: String) {
        guard coinImages[url] == nil, !loadingImageURLs.contains(url) else {
            return
        }
        loadingImageURLs.insert(url)

        homeRepo
            .getCoinImage(urlString: url)
            .map { UIImage(data: $0) }
            .sink { [weak self] (_) in
                self?.loadingImageURLs.remove(url)
            } receiveValue: { [weak self] image in
                self?.coinImages[url] = image
            }
            .store(in: &cancellables)

    }

    private func mapGlobalMarketData(
        globalData: GlobalData?,
    ) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let globalData = globalData else {
            return stats
        }

        let marketCap = StatisticModel(
            title: "Market Cap",
            value: globalData.data?.marketCap ?? "",
            percentageChange: globalData.data?.marketCapChangePercentage24HUsd
        )
        let volume = StatisticModel(
            title: "24h Volume",
            value: globalData.data?.volume ?? ""
        )
        let btcDominance = StatisticModel(
            title: "BTC Dominance",
            value: globalData.data?.btcDominance ?? ""
        )

        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: "$0.00",
            percentageChange: 0
        )

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio,
        ])
        return stats
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = text.lowercased()

        return coins.filter { coin in
            (coin.name?.lowercased().contains(lowercasedText) ?? false)
                || (coin.symbol?.lowercased().contains(lowercasedText) ?? false)
                || (coin.id?.lowercased().contains(lowercasedText) ?? false)
        }
    }

}
