//
//  HomeAPIClinet.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Combine
import Foundation
import SwiftUI

protocol HomeAPIClientProtocol {

    func getCoins() -> AnyPublisher<[CoinModel], Error>
    func getCoinImage(urlString: String) -> AnyPublisher<Data, Error>
    func getMarketStats() -> AnyPublisher<GlobalData, Error>

}

struct HomeAPIClient: HomeAPIClientProtocol {

    func getMarketStats() -> AnyPublisher<GlobalData, Error> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return NetworkingManager.execute(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }

    func getCoinImage(urlString: String) -> AnyPublisher<Data, Error> {
        guard
            let url = URL(
                string:
                    urlString
            )
        else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return NetworkingManager.execute(url: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getCoins() -> AnyPublisher<[CoinModel], Error> {

        guard
            let url = URL(
                string:
                    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
            )
        else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return NetworkingManager.execute(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
