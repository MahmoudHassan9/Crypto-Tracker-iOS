//
//  DI.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import Foundation

struct DIContainer {
    static let homeViewModel: HomeViewModel = HomeViewModel(
        homeRepo: HomeRepoImp(
            apiCLient: HomeAPIClient(),
            imageCache: ImageCache(),
        ),
        portfolioDataService: PortfolioDataService()
    )

}
