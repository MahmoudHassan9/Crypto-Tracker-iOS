//
//  HomeAPIClinet.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Combine
import Foundation

protocol HomeAPIClientProtocol {

    func getCoins() -> AnyPublisher<[CoinModel], Error>

}

struct HomeAPIClient: HomeAPIClientProtocol {

    private let url = URL(
        string:
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    )!

    func getCoins() -> AnyPublisher<[CoinModel], Error> {
        return NetworkingManager.execute(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
