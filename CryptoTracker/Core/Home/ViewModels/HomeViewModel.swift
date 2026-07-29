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

    @Published var allCoinsList: [CoinModel] = []
    @Published var portfolioCoinsList: [CoinModel] = []
    @Published var coinImages: [String: UIImage] = [:]
    @Published var loadingImageURLs: Set<String> = []
    private var cancellables: Set<AnyCancellable> = []

    private let homeRepo: HomeRepoProtocol

    init(
        homeRepo: HomeRepoProtocol
    ) {
        self.homeRepo = homeRepo
        getCoins()
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

    func getCoins() {
        homeRepo
            .getCoins()
            .replaceError(with: [])
            .sink(
                receiveValue: { [weak self] coins in
                    self?.allCoinsList = coins
                }
            )
            .store(in: &cancellables)
    }

}
