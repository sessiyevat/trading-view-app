//
//  View+Extensions.swift
//  TradingView
//
//  Created by Tomiris S. on 12/18/23.
//

import SwiftUI

extension View {
    func headerCellStyle() -> some View {
        self
            .font(Fonts.shared.customFont(weight: .medium, size: 12))
            .foregroundColor(Assets.Colors.textGray)
    }

    func bodyTextStyle() -> some View {
        self
            .font(Fonts.shared.customFont(weight: .medium, size: 14))
            .foregroundColor(.white)
    }
}
