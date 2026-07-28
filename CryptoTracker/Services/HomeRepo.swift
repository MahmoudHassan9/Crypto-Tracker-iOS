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
}

struct HomeRepoImp: HomeRepoProtocol {

    private let apiCLient: HomeAPIClientProtocol
    
    init(apiCLient: HomeAPIClientProtocol) {
        self.apiCLient = apiCLient
    }
    func getCoins() -> AnyPublisher<[CoinModel], any Error> {
        apiCLient.getCoins()
    }

}
