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

    init() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoinsList.append(CoinModel.fakeCoin)
            self.allCoinsList.append(CoinModel.fakeCoin)
            self.portfolioCoinsList.append(CoinModel.fakeCoin)

        }

    }

}
