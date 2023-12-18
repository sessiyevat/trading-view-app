//
//  TradeView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI
import WebKit

struct TradeView: View {
    
    @ObservedObject var viewModel: TradeViewModel
    @State private var keyboardHeight: CGFloat = .zero
    
    init(viewModel: TradeViewModel = TradeViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Assets.Colors.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack(spacing: .zero) {
                    Text(Constants.Text.title)
                        .font(Fonts.shared.customFont(weight: .bold, size: 22))
                        .padding(.top, Constants.Layout.textTopPadding)
                        .foregroundColor(.white)
                    
                    VStack(spacing: Constants.Layout.balanceSpacing) {
                        Text(Constants.Text.balance)
                            .font(Fonts.shared.customFont(weight: .medium, size: 12))
                            .foregroundColor(Assets.Colors.textGraySecondary)
                            .multilineTextAlignment(.center)
                        
                        Text(viewModel.trade.balance.formattedString())
                            .font(Fonts.shared.customFont(weight: .semiBold, size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(height: Constants.Layout.balanceHeight)
                    .frame(maxWidth: .infinity)
                    .background(Assets.Colors.graySecondary)
                    .cornerRadius(12)
                    .padding(.top, Constants.Layout.balanceTopPadding)
                    
                    WebView(url: viewModel.currentURL)
                        .frame(height: Constants.Layout.webViewHeight)
                        .foregroundColor(.clear)
                        .padding(.top, Constants.Layout.webViewTopPadding)
                    
                    ControlView(viewModel: viewModel)
                        .onAppear {
                            setupKeyboardObservers()
                        }
                        .onDisappear {
                            removeKeyboardObservers()
                        }
                    
                    Spacer()
                }
                .padding(.horizontal, Constants.Layout.horizontalPadding)
                .padding(.bottom, keyboardHeight)
                .background(Assets.Colors.backgroundSecondary)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.keyboardHeight = keyboardFrame.height
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            self.keyboardHeight = .zero
        }
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TradeView {
    private enum Constants {
        enum Layout {
            static let textTopPadding: CGFloat = 20
            static let balanceSpacing: CGFloat = 7
            static let balanceHeight: CGFloat = 50
            static let balanceTopPadding: CGFloat = 15
            static let webViewHeight: CGFloat = 322
            static let webViewTopPadding: CGFloat = 25
            static let horizontalPadding: CGFloat = 30
        }
        
        enum Text {
            static let title: String = "Trade"
            static let balance: String = "Balance"
        }
    }
}
