//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import SwiftUI

struct HomeView: View {

    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            Color
                .theme
                .background
                .ignoresSafeArea()

            VStack {
                homeHeader
                Spacer()
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
}

#Preview {
    NavigationView {
        HomeView()
    }
    .toolbar(.hidden)
}
