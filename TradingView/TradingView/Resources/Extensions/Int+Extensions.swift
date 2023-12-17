//
//  Int+Extensions.swift
//  TradingView
//
//  Created by Tomiris S. on 12/18/23.
//

extension Int {
    func formatTimer() -> String {
        let minutes = self / 60
        let remainingSeconds = self % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
