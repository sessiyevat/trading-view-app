//
//  TradeModel.swift
//  TradingView
//
//  Created by Tomiris S. on 12/14/23.
//

import Foundation

struct Trade {
    let balance: Double
    let currencyPair: CurrencyPair
    let timer: Int
    var investment: Int
    
    init(
        balance: Double = .zero,
        currencyPair: CurrencyPair = .init(String(), String()),
        timer: Int = .zero,
        investment: Int = .zero
    ) {
        self.balance = balance
        self.currencyPair = currencyPair
        self.timer = timer
        self.investment = investment
    }
}

struct CurrencyPair: Hashable {
    let first: String
    let second: String
    
    init(_ first: String, _ second: String) {
        self.first = first
        self.second = second
    }
}
