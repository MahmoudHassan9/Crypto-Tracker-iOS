//
//  HomeRepo.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Combine
import Foundation

protocol HomeRepoProtocol {
    func getCoins() -> AnyPublisher<[CoinModel], Error>
    func getCoinImage(urlString: String) -> AnyPublisher<Data, Error>
}

struct HomeRepoImp: HomeRepoProtocol {

    private let apiCLient: HomeAPIClientProtocol

    init(apiCLient: HomeAPIClientProtocol) {
        self.apiCLient = apiCLient
    }
    func getCoinImage(urlString: String) -> AnyPublisher<Data, Error> {
        apiCLient.getCoinImage(urlString: urlString)
    }
    func getCoins() -> AnyPublisher<[CoinModel], any Error> {
        apiCLient.getCoins()
    }

}
