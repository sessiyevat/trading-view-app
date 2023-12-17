//
//  ContentView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationView {
            WelcomeView(viewModel: viewModel)
                .background(
                    NavigationLink(
                        destination: MainView().navigationBarHidden(true),
                        isActive: $viewModel.isPreloadingDone,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                )
        }
    }
}
