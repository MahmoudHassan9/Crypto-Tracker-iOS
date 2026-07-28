//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            Color
                .theme
                .background
                .ignoresSafeArea()

            VStack {
                homeHeader

                columnTitles

                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }

                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

            }
        }
    }
}

extension HomeView {

    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )

            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)

            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }

        }
        .padding(.horizontal)
    }

    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoinsList) { coin in
                CoinRowView(coinModel: coin, showHolding: false)
                    .listRowInsets(
                        .init(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
        }
        .listStyle(.plain)

    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoinsList) { coin in
                CoinRowView(coinModel: coin, showHolding: false)
                    .listRowInsets(
                        .init(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
        }
        .listStyle(.plain)

    }

    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(
                    width: UIScreen.main.bounds.width / 3,
                    alignment: .trailing
                )
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

#Preview("light") {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DIContainer.homeViewModel)
    .toolbar(.hidden)
}

#Preview("dark") {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DIContainer.homeViewModel)
    .toolbar(.hidden)
    .preferredColorScheme(.dark)
}
