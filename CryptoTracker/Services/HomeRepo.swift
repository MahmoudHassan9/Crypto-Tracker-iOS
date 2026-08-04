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
    func getMarketStats() -> AnyPublisher<GlobalData, Error>
    func getCoinDetails(id: String) -> AnyPublisher<CoinDetailModel, Error>

}

struct HomeRepoImp: HomeRepoProtocol {

    private let apiCLient: HomeAPIClientProtocol
    private let imageCache: CacheProtocol

    init(
        apiCLient: HomeAPIClientProtocol,
        imageCache: CacheProtocol
    ) {
        self.apiCLient = apiCLient
        self.imageCache = imageCache
    }

    func getCoinDetails(id: String) -> AnyPublisher<CoinDetailModel, any Error>
    {
        apiCLient.getCoinDetails(id: id)
    }

    func getMarketStats() -> AnyPublisher<GlobalData, any Error> {
        apiCLient.getMarketStats()
    }

    func getCoinImage(urlString: String) -> AnyPublisher<Data, Error> {

        if let cached = imageCache.data(for: urlString) {
            print("cacheddd !")
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return apiCLient.getCoinImage(urlString: urlString)
            .handleEvents(receiveOutput: { data in
                print("cachingggg !")
                imageCache.insertData(data, for: urlString)
            })
            .eraseToAnyPublisher()
    }

    func getCoins() -> AnyPublisher<[CoinModel], any Error> {
        apiCLient.getCoins()
    }

}
