//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 01/08/2026.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList

                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                showSaveButton()
                    ? ToolbarItem(placement: .navigationBarTrailing) {
                        trailingNavBarButtons
                    } : nil
            })
            //            .onChange(
            //                of: vm.searchText,
            //                perform: { value in
            //                    if value == "" {
            //                        removeSelectedCoin()
            //                    }
            //                }
            //            )
        }

    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(DIContainer.homeViewModel)
    }
}

extension PortfolioView {

    private var coinLogoList: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false,
            content: {
                LazyHStack(spacing: 10) {
                    ForEach(
                        vm.searchText.isEmpty
                            ? vm.allCoinsList : vm.filteredCoins
                    ) { coin in
                        CoinLogoView(coin: coin)
                            .frame(width: 75)
                            .padding(4)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    updateSelectedCoin(coin: coin)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        selectedCoin?.id == coin.id
                                            ? Color.theme.green : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
                }
                .frame(height: 120)
                .padding(.leading)
            }
        )
    }

    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin

        if let portfolioCoin = vm.portfolioCoinsList.first(where: {
            $0.id == coin.id
        }),
            let amount = portfolioCoin.currentHolding
        {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text(
                    "Current price of \(selectedCoin?.symbol?.uppercased() ?? ""):"
                )
                Spacer()
                Text(
                    selectedCoin?.currentPrice?.asCurrencyWith6Decimals() ?? ""
                )
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }

    private var trailingNavBarButtons: some View {

        HStack(spacing: 0) {

            if showCheckmark {
                Image(systemName: "checkmark")
            }
            if !showCheckmark {
                Button(
                    action: {
                        saveButtonPressed()
                    },
                    label: {
                        Text("Save".uppercased())
                    }
                )

            }
        }
        .font(.headline)
    }

    private func saveButtonPressed() {

        //        guard
        //            let coin = selectedCoin,
        //            let amount = Double(quantityText)
        //        else { return }

        // save to portfolio
        //        vm.updatePortfolio(coin: coin, amount: amount)

        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }

        // hide keyboard
        UIApplication.shared.endEditing()

        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }

    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }

    private func showSaveButton() -> Bool {
        return
            (selectedCoin != nil
            && selectedCoin?.currentHolding != Double(quantityText))
            || showCheckmark
    }

}
