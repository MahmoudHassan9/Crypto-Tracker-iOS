//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 29/07/2026.
//

import SwiftUI

struct CoinImageView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    let url: String

    init(url: String) {
        self.url = url
    }

    var body: some View {
        ZStack {
            if let image = homeViewModel.coinImages[url] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if homeViewModel.loadingImageURLs.contains(url) {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
        .task {
            homeViewModel.getCoinImage(for: url)
        }
    }
}

#Preview {
    NavigationStack {
        CoinImageView(url: CoinModel.fakeCoin.image ?? "")
    }
    .toolbar(.hidden)
    .environmentObject(DIContainer.homeViewModel)
}
