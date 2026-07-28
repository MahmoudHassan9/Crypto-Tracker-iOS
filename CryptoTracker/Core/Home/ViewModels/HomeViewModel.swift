//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {

    @Published var allCoinsList: [CoinModel] = []
    @Published var portfolioCoinsList: [CoinModel] = []

    private let homeRepo: HomeRepoProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(
        homeRepo: HomeRepoProtocol
    ) {
        self.homeRepo = homeRepo
        getCoins()
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
