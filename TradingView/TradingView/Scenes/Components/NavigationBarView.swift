//
//  NavigationBarView.swift
//  TradingView
//
//  Created by Tomiris S. on 12/17/23.
//

import SwiftUI

struct NavigationBarView<LeftBarItem: View, RightBarItem: View>: View {
    
    private let leftBarItem: LeftBarItem?
    private let rightBarItem: RightBarItem?
    private let title: Text
    
    init(
        leftBarItem: LeftBarItem? = EmptyView(),
        rightBarItem: RightBarItem? = EmptyView(),
        title: Text
    ) {
        self.leftBarItem = leftBarItem
        self.rightBarItem = rightBarItem
        self.title = title
    }

    var body: some View {
        VStack(spacing: .zero) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 44)
                .overlay(
                    ZStack {
                        HStack {
                            leftBarItem
                            Spacer()
                            rightBarItem
                        }
                        .padding(.horizontal)

                        title
                            .multilineTextAlignment(.center)
                    }
                )
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
}

