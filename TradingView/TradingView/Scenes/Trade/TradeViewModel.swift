//
//  TradeViewModel.swift
//  TradingView
//
//  Created by Tomiris S. on 12/14/23.
//

import Foundation

final class TradeViewModel: ObservableObject {
    
    @Published var trade: Trade
    @Published var currentURL: URL?
    @Published var timerValue: Int
    @Published var investmentValue: Int
    @Published var currentCurrencyPair: CurrencyPair
    @Published var currencyPairs: [CurrencyPair] = []
    
    private var urlIndex: Int = .zero
    private var urls: [URL] = []

    init(trade: Trade = Trade(balance: 1000, currencyPair: .init("EUR", "USD"))) {
        self.trade = trade
        timerValue = trade.timer
        investmentValue = trade.investment
        currentCurrencyPair = trade.currencyPair
        fetchMockData()
    }
    
    func toggleChart() {
        urlIndex = (urlIndex + 1) % urls.count
        currentURL = urls[urlIndex]
    }
    
    func increaseTimer() {
        timerValue += 5
    }
    
    func decreaseTimer() {
        timerValue = max(0, timerValue - 5)
    }
    
    func increaseInvestment() {
        investmentValue += 10
    }
    
    func decreaseInvestment() {
        investmentValue = max(0, investmentValue - 10)
    }
    
    func setCurrentCurrencyPair(_ currencyPair: CurrencyPair) {
        self.currentCurrencyPair = currencyPair
    }
    
    private func fetchMockData() {
        currencyPairs = [
            .init("EUR", "USD"),
            .init("GBP", "USD"),
            .init("USD", "JPY"),
            .init("AUD", "USD"),
            .init("USD", "CAD"),
            .init("NZD", "USD")
        ]
        
        urls = [
            URL(string: "https://www.tradingview.com/chart/?symbol=BMFBOVESPA%3AEUR1%21")!,
            URL(string: "https://www.tradingview.com/chart/?symbol=NASDAQ%3AGBP")!
        ]
        
        currentURL = urls[urlIndex]
    }
}
