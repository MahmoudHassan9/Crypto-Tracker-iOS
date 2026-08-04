//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false  // animate right
    @State private var showPortfolioView: Bool = false  // new sheet
    @State private var selectedCoin: CoinModel? = nil

    var body: some View {
        ZStack {
            Color
                .theme
                .background
                .ignoresSafeArea()
                .sheet(
                    isPresented: $showPortfolioView,
                    content: {
                        PortfolioView()
                            .environmentObject(homeViewModel)
                    }
                )

            VStack {
                homeHeader

                HomeStatsView(showPortfolio: $showPortfolio)

                SearchBarView(searchText: $homeViewModel.searchText)

                columnTitles

                if !showPortfolio {
                    if homeViewModel.coinsIsLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                }

                if showPortfolio {
                    ZStack(alignment: .top) {
                        if homeViewModel.portfolioCoinsList.isEmpty
                            && homeViewModel.searchText.isEmpty
                        {
                            portfolioEmptyText
                        } else {
                            portfolioCoinsList
                        }
                    }
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
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

            ForEach(homeViewModel.filteredCoins) { coin in
                NavigationLink(value: coin) {
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
        }
        .listStyle(.plain)
        .navigationDestination(
            for: CoinModel.self,
            destination: { coin in
                DetailView(coin: coin)
            }
        )
        .refreshable {
            homeViewModel.reloadData()
        }

    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoinsList) { coin in
                CoinRowView(coinModel: coin, showHolding: true)
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
    private var portfolioEmptyText: some View {
        Text(
            "You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐"
        )
        .font(.callout)
        .foregroundColor(Color.theme.accent)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .padding(50)
    }

    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(
                        (homeViewModel.sortOption == .rank
                            || homeViewModel.sortOption == .rankReversed)
                            ? 1.0 : 0.0
                    )
                    .rotationEffect(
                        Angle(
                            degrees: homeViewModel.sortOption == .rank ? 0 : 180
                        )
                    )
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption =
                        homeViewModel.sortOption == .rank
                        ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(
                            (homeViewModel.sortOption == .holdings
                                || homeViewModel.sortOption == .holdingsReversed)
                                ? 1.0 : 0.0
                        )
                        .rotationEffect(
                            Angle(
                                degrees: homeViewModel.sortOption == .holdings
                                    ? 0 : 180
                            )
                        )
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption =
                            homeViewModel.sortOption == .holdings
                            ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(
                        (homeViewModel.sortOption == .price
                            || homeViewModel.sortOption == .priceReversed)
                            ? 1.0 : 0.0
                    )
                    .rotationEffect(
                        Angle(
                            degrees: homeViewModel.sortOption == .price
                                ? 0 : 180
                        )
                    )
            }
            .frame(
                width: UIScreen.main.bounds.width / 3.5,
                alignment: .trailing
            )
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption =
                        homeViewModel.sortOption == .price
                        ? .priceReversed : .price
                }
            }
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
