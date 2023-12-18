//
//  TradersView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI

struct TradersView: View {
    
    @ObservedObject var viewModel: TradersViewModel
    
    init(viewModel: TradersViewModel = TradersViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Assets.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                Text(Constants.Text.title)
                    .font(Fonts.shared.customFont(weight: .bold, size: 22))
                    .padding(.top, Constants.Layout.textTopPadding)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                
                if #available(iOS 16.0, *) {
                    tradersList
                        .background(.clear)
                        .scrollContentBackground(.hidden)
                } else {
                    tradersList
                        .listStyle(.insetGrouped)
                        .background(Assets.Colors.background.ignoresSafeArea())
                        .onAppear {
                            UITableView.appearance().backgroundColor = .clear
                        }
                }
            }
            .background(Assets.Colors.background)
            .onAppear {
                viewModel.startFetchingData()
            }
        }
    }

    private var tradersList: some View {
        List {
            headerRow

            ForEach(viewModel.traders.indices, id: \.self) { index in
                tradeRow(index: index)
            }
        }
    }

    private var headerRow: some View {
        HStack {
            Text(Constants.Text.no)
                .headerCellStyle()
            Text(Constants.Text.country)
                .headerCellStyle()
                .padding(.leading, Constants.Layout.leadingPadding)
            Text(Constants.Text.name)
                .headerCellStyle()
                .padding(.leading, Constants.Layout.textTopPadding)
            Spacer()
            Text(Constants.Text.deposit)
                .headerCellStyle()
            Spacer()
            Text(Constants.Text.profit)
                .headerCellStyle()
        }
        .frame(height: Constants.Layout.rowHeight)
        .padding(.horizontal)
        .listRowInsets(EdgeInsets())
        .background(Assets.Colors.darkBlue)
    }

    private func tradeRow(index: Int) -> some View {
        let trader = viewModel.traders[index]

        return HStack {
            Text("\(index + 1)")
                .foregroundColor(Assets.Colors.textGray)
                .bodyTextStyle()
                .frame(width: Constants.Layout.numberWidth, alignment: .leading)
            Image(trader.country)
                .padding(.leading, Constants.Layout.imageLeadingPadding)
            Spacer()
            Text(trader.name)
                .bodyTextStyle()
            Spacer()
            Text("$\(Int(trader.deposit))")
                .bodyTextStyle()
            Spacer()
            Text("$\(Int(trader.profit))")
                .foregroundColor(Assets.Colors.greenPrimary)
                .bodyTextStyle()
        }
        .frame(height: Constants.Layout.rowHeight)
        .padding(.horizontal)
        .listRowInsets(EdgeInsets())
        .background(index % 2 == 0 ? Assets.Colors.background : Assets.Colors.darkBlue)
    }
}

// MARK: - Constants

extension TradersView {
    private enum Constants {
        enum Layout {
            static let textTopPadding: CGFloat = 20
            static let rowHeight: CGFloat = 50
            static let numberWidth: CGFloat = 28
            static let leadingPadding: CGFloat = 15
            static let imageLeadingPadding: CGFloat = 5
        }
        
        enum Text {
            static let title: String = "TOP 10 Traders"
            static let no: String = "№"
            static let country: String = "Country"
            static let name: String = "Name"
            static let deposit: String = "Deposit"
            static let profit: String = "Profit"
        }
    }
}
