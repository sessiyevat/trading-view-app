//
//  WelcomeView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject var viewModel: WelcomeViewModel
    
    var body: some View {
        ZStack {
            Assets.Colors.background
                .ignoresSafeArea()
            
            RadialGradient(
                gradient: Gradient(colors: [Assets.Colors.greenPrimary, .clear]),
                center: .center,
                startRadius: Constants.Gradient.startRadius,
                endRadius: Constants.Gradient.endRadius
            )
            .blur(radius: Constants.Gradient.blurRadius)
            .position(Constants.Gradient.greenPosition)

            RadialGradient(
                gradient: Gradient(colors: [Assets.Colors.redPrimary, .clear]),
                center: .center,
                startRadius: Constants.Gradient.startRadius,
                endRadius: Constants.Gradient.endRadius
            )
            .blur(radius:  Constants.Gradient.blurRadius)
            .position(Constants.Gradient.redPosition)
            ProgressBar(
                width: Constants.ProgressBar.width,
                height: Constants.ProgressBar.height,
                percent: viewModel.loadingPercent
            )
        }
        .background(Assets.Colors.background)
        .navigationBarHidden(true)
    }
}

// MARK: - Constants

extension WelcomeView {
    private enum Constants {
        enum Gradient {
            static let startRadius: CGFloat = 15
            static let endRadius: CGFloat = 130
            static let blurRadius: CGFloat = 100
            static let greenPosition = CGPoint(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height * 0.25)
            static let redPosition = CGPoint(x: 50, y: UIScreen.main.bounds.height * 0.6)
        }
        
        enum ProgressBar {
            static let width: CGFloat = 300
            static let height: CGFloat = 24
        }
    }
}

