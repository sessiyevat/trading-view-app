//
//  Double+Extensions.swift
//  TradingView
//
//  Created by Tomiris S. on 12/18/23.
//

import Foundation

extension Double {
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        if let formattedBalance = formatter.string(from: NSNumber(value: self)) {
            return formattedBalance
        } else {
            return "\(self)"
        }
    }
}
