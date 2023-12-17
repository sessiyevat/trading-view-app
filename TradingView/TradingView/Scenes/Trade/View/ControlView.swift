//
//  ControlView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/14/23.
//

import SwiftUI
import WebKit

struct ControlView: View {
    
    @ObservedObject var viewModel: TradeViewModel
    @State private var isTimerFocused: Bool = false
    @State private var isInvestmentFocused: Bool = false
    @State private var timerText: String
    @State private var investmentText: String
    
    init(viewModel: TradeViewModel) {
        self.viewModel = viewModel
        investmentText = String(viewModel.investmentValue)
        timerText = viewModel.timerValue.formatTimer()
    }
    
    var body: some View {
        VStack(spacing: Constants.Layout.mainStackSpacing) {
            currencyPairs()
            inputFields()
            actionButtons()
        }
        .background(Assets.Colors.backgroundSecondary)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            isTimerFocused = false
            isInvestmentFocused = false
        }
    }
    
    private func currencyPairs() -> some View {
        NavigationLink(destination: CurrencyListView(viewModel: viewModel), label: {
            ZStack {
                HStack {
                    Spacer()
                    Assets.Icons.rightArrow
                        .resizable()
                        .frame(width: Constants.Layout.iconSize, height: Constants.Layout.iconSize)
                        .foregroundColor(.white)
                        .padding(.trailing, Constants.Layout.iconPadding)
                }

                Text("\(viewModel.currentCurrencyPair.first)/\(viewModel.currentCurrencyPair.second)")
                    .font(Fonts.shared.customFont(weight: .semiBold, size: 16))
                    .foregroundColor(.white)
            }
        })
        .frame(height: Constants.Layout.height)
        .frame(maxWidth: .infinity)
        .background(Assets.Colors.graySecondary)
        .cornerRadius(Constants.Layout.cornerRadius)
        .padding(.top, Constants.Layout.linkTopPadding)
    }
    
    private func inputFields() -> some View {
        HStack(spacing: Constants.Layout.hStackSpacing) {
            inputField(
                title: Constants.Text.timer,
                placeholder: Constants.Text.defaultTimer,
                type: .timer,
                focused: $isTimerFocused,
                onTapGesture: {
                    isTimerFocused = true
                    isInvestmentFocused = false
                },
                decreaseAction: {
                    viewModel.decreaseTimer()
                    timerText = viewModel.timerValue.formatTimer()
                },
                increaseAction: {
                    viewModel.increaseTimer()
                    timerText = viewModel.timerValue.formatTimer()
                }
            )

            inputField(
                title: Constants.Text.investment,
                placeholder: Constants.Text.defaultInvestment,
                type: .investment,
                focused: $isInvestmentFocused,
                onTapGesture: {
                    isTimerFocused = false
                    isInvestmentFocused = true
                },
                decreaseAction: {
                    viewModel.decreaseInvestment()
                    investmentText = String(viewModel.investmentValue)
                }, increaseAction: {
                    viewModel.increaseInvestment()
                    investmentText = String(viewModel.investmentValue)
                }
            )
        }
    }
    
    private func inputField(
        title: String,
        placeholder: String,
        type: InputFieldType,
        focused: Binding<Bool>,
        onTapGesture: @escaping () -> Void,
        decreaseAction: @escaping () -> Void,
        increaseAction: @escaping () -> Void
    ) -> some View {
        VStack(spacing: Constants.Layout.vStackSpacing) {
            Text(title)
                .font(Fonts.shared.customFont(weight: .medium, size: 12))
                .foregroundColor(Assets.Colors.textGraySecondary)

            ZStack {
                HStack {
                    Button(action: {
                        decreaseAction()
                        onTapGesture()
                    }) {
                        Assets.Icons.minus
                            .foregroundColor(Assets.Colors.textGraySecondary)
                    }
                    Spacer()
                    Button(action: {
                        increaseAction()
                        onTapGesture()
                    }) {
                        Assets.Icons.plus
                            .foregroundColor(Assets.Colors.textGraySecondary)
                    }
                }
                switch type {
                    case .timer:
                        TextField(placeholder, text: $timerText)
                        .onChange(of: timerText) { newValue in
                            timerText = newValue.formatTimer()
                            viewModel.timerValue = newValue.parseSeconds()
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, Constants.Layout.textFieldPadding)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numbersAndPunctuation)
                        .onTapGesture {
                            withAnimation {
                                onTapGesture()
                            }
                        }
                    case .investment:
                        TextField(placeholder, text: $investmentText)
                            .onChange(of: investmentText) { newValue in
                                investmentText = newValue
                                viewModel.investmentValue = Int(newValue) ?? 0
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, Constants.Layout.textFieldPadding)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .onTapGesture {
                                withAnimation {
                                    onTapGesture()
                                }
                            }
                }
            }
        }
        .frame(height: Constants.Layout.height)
        .padding(.horizontal, Constants.Layout.iconPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius)
                .stroke(focused.wrappedValue ? Assets.Colors.greenPrimary : .clear, lineWidth: Constants.Layout.lineWidth)
        )
        .background(Assets.Colors.graySecondary)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
    
    private func actionButtons() -> some View {
        HStack(spacing: Constants.Layout.hStackSpacing) {
            actionButton(title: Constants.Text.sell, backgroundColor: Assets.Colors.redSecondary)
            actionButton(title: Constants.Text.buy, backgroundColor: Assets.Colors.greenPrimary)
        }
    }

    private func actionButton(title: String, backgroundColor: Color) -> some View {
        Button(action: {}) {
            
            HStack {
                Text(title)
                    .font(Fonts.shared.customFont(weight: .medium, size: 24))
                    .foregroundColor(.white)
                    .padding(.leading, Constants.Layout.buttonTextPadding)
                Spacer()
            }
        }
        .frame(height: Constants.Layout.height)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

extension ControlView {
    private enum InputFieldType {
        case timer
        case investment
    }
}

// MARK: - Constants

extension ControlView {
    private enum Constants {
        enum Layout {
            static let mainStackSpacing: CGFloat = 10
            static let iconSize: CGFloat = 24
            static let iconPadding: CGFloat = 15
            static let linkTopPadding: CGFloat = 25
            static let hStackSpacing: CGFloat = 11
            static let vStackSpacing: CGFloat = 7
            static let textFieldPadding: CGFloat = 40
            static let cornerRadius: CGFloat = 12
            static let height: CGFloat = 54
            static let lineWidth: CGFloat = 1
            static let buttonTextPadding: CGFloat = 20
        }
        
        enum Text {
            static let timer: String = "Timer"
            static let investment: String = "Investment"
            static let defaultTimer: String = "00:00"
            static let defaultInvestment: String = "0"
            static let sell: String = "Sell"
            static let buy: String = "Buy"
        }
    }
}
