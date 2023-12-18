//
//  MainView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TradersView()
            .tabItem {
                Assets.Icons.trade
                    .renderingMode(.template)
                    .foregroundColor(Assets.Colors.icon)
                Text(Constants.Text.trade)
            }
           
            TradeView()
            .tabItem {
                Assets.Icons.top
                    .renderingMode(.template)
                    .foregroundColor(Assets.Colors.icon)
                Text(Constants.Text.top)
            }
       }
       .accentColor(Assets.Colors.greenPrimary)
       .onAppear {
           if #available(iOS 15.0, *) {
               let appearance = UITabBarAppearance()
               appearance.shadowColor = Constants.Color.shadow
               appearance.backgroundColor = Constants.Color.tabBar
               UITabBar.appearance().scrollEdgeAppearance = appearance
           } else {
               UITabBar.appearance().barTintColor = Constants.Color.tabBar
           }
       }
       .navigationBarHidden(true)
    }
}

// MARK: - Constants

extension MainView {
    private enum Constants {
        enum Color {
            static let shadow: UIColor = .init(Assets.Colors.shadow.opacity(0.8))
            static let tabBar: UIColor = .init(Assets.Colors.tabBar)
        }
        
        enum Text {
            static let trade: String = "Trade"
            static let top: String = "Top"
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
