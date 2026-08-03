//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 03/08/2026.
//

import SwiftUI

struct DetailView: View {
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        print("coin name is \(coin.name ?? "empty")")
    }
    var body: some View {
        Text( /*@START_MENU_TOKEN@*/"Hello, World!" /*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailView(
        coin: CoinModel.fakeCoin
    )
}
