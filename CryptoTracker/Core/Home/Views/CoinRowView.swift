//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 28/07/2026.
//

import SwiftUI

struct CoinRowView: View {

    let coinModel: CoinModel
    let showHolding: Bool

    var body: some View {

        HStack {

            leftColumn
            Spacer()
            if showHolding {
                centerColumn
            }
            rightColumn

        }.font(.subheadline)
    }
}

extension CoinRowView {

    private var leftColumn: some View {

        HStack {
            Text("\(coinModel.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 15)

            CoinImageView(url: coinModel.image ?? "")
                .frame(width: 30, height: 30)

            Text(coinModel.symbol?.uppercased() ?? "")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
        }

    }

    private var centerColumn: some View {

        VStack(alignment: .trailing) {

            Text(
                coinModel.currentHoldingValue.asCurrencyWith2Decimals()
            )
            .bold()
            .foregroundStyle(Color.theme.accent)

            Text(coinModel.currentHolding?.asNumberString() ?? "")
                .foregroundStyle(Color.theme.accent)

        }

    }

    private var rightColumn: some View {

        VStack(alignment: .trailing) {
            Text(coinModel.currentPrice?.asCurrencyWith6Decimals() ?? "")
                .bold()
                .foregroundStyle(Color.theme.accent)

            Text(
                coinModel.priceChangePercentage24H?.asPercentString() ?? ""
            )
            .foregroundStyle(
                coinModel.priceChangePercentage24H ?? 0 >= 0
                    ? Color.theme.green : Color.theme.red
            )
        }
        .frame(
            width: UIScreen.main.bounds.width / 3,
            alignment: .trailing
        )
    }
}

#Preview("Light", traits: .sizeThatFitsLayout) {
    CoinRowView(
        coinModel: .fakeCoin,
        showHolding: true
    )
}

#Preview("Dark") {
    CoinRowView(
        coinModel: .fakeCoin,
        showHolding: true
    )
    .preferredColorScheme(.dark)
}
