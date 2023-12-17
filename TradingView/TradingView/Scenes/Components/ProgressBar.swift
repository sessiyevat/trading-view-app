//
//  ProgressBar.swift
//  TradingView
//
//  Created by Tomiris S. on 12/12/23.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    var percent: CGFloat = .zero
        
    var body: some View {
        
        let multiplier = width / 100
        
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(Assets.Colors.grayPrimary)
            
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .frame(width: multiplier * percent, height: height)
                .foregroundColor(Assets.Colors.greenPrimary)
                .offset(x: -width / 2 + multiplier * percent / 2)
                .animation(.spring(), value: percent)
            
            Text("\(Int(percent))%")
                .foregroundColor(.white)
                .font(Fonts.shared.customFont(weight: .extraBold, size: 16))
        }
    }
}

// MARK: - Constants

extension ProgressBar {
    private enum Constants {
        static let cornerRadius: CGFloat = 30
    }
}
