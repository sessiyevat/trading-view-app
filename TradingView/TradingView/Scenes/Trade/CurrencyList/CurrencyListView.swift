//
//  CurrencyListView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/16/23.
//

import SwiftUI

struct CurrencyListView: View {
    
    @ObservedObject var viewModel: TradeViewModel
    
    private let columns: [GridItem] = [
        GridItem(.fixed(Constants.Layout.width), spacing: Constants.Layout.spacing),
        GridItem(.fixed(Constants.Layout.width), spacing: Constants.Layout.spacing)
    ]
    
    var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                leftBarItem: CustomBackButton(icon: 
                    Assets.Icons.leftArrow
                        .foregroundColor(.white)
                        .imageScale(.large)
                ),
                title:
                    Text(Constants.Text.title)
                        .font(Fonts.shared.customFont(weight: .bold, size: 22))
                        .foregroundColor(.white)
            )
            
            LazyVGrid(columns: columns, alignment: .center, spacing: Constants.Layout.spacing) {
                ForEach(viewModel.currencyPairs, id: \.self) { currencyPair in
                    Button(action: {
                        viewModel.setCurrentCurrencyPair(currencyPair)
                        viewModel.toggleChart()
                    }) {
                        Text("\(currencyPair.first)/\(currencyPair.second)")
                            .frame(width: Constants.Layout.width, height: Constants.Layout.height)
                            .background(currencyPair == viewModel.currentCurrencyPair ? Assets.Colors.greenPrimary : Assets.Colors.graySecondary)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.Layout.cornerRadius)
                    }
                }
            }
            .padding(.top, Constants.Layout.gridTopPadding)
            
            Spacer()
        }
        .background(Assets.Colors.backgroundSecondary)
        .navigationBarHidden(true)
    }
}

// MARK: - Constants

extension CurrencyListView {
    private enum Constants {
        enum Text {
            static let title: String = "Currency Pairs"
        }
        
        enum Layout {
            static let spacing: CGFloat = 20
            static let width: CGFloat = 140
            static let height: CGFloat = 54
            static let cornerRadius: CGFloat = 12
            static let gridTopPadding: CGFloat = 30
            static let topPadding: CGFloat = 20
        }
    }
}





