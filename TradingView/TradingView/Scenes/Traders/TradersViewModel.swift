//
//  TradersViewModel.swift
//  TradingView
//
//  Created by Tomiris S. on 12/13/23.
//

import SwiftUI

final class TradersViewModel: ObservableObject {
    
    @Published var traders: [Trader] = []

    private var timer: Timer?

    init() {
        fetchMockData()
    }

    deinit {
        timer?.invalidate()
    }

    func startFetchingData() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.updateData()
        }
    }

    private func fetchMockData() {
        traders = [
            Trader(id: 1, country: "Austria", name: "Oliver", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 2, country: "Oman", name: "Jack", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 3, country: "Ethiopia", name: "Harry", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 4, country: "Tanzania", name: "Jacob", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 5, country: "Nicaragua", name: "Charley", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 6, country: "Uganda", name: "Thomas", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 7, country: "Slovenia", name: "George", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 8, country: "Zimbabwe", name: "Oscar", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 9, country: "Sao-Tome", name: "James", deposit: getRandomDeposit(), profit: getRandomProfit()),
            Trader(id: 10, country: "Italy", name: "William", deposit: getRandomDeposit(), profit: getRandomProfit())
        ]
        
        traders.sort(by: { $0.profit > $1.profit })
    }
    
    private func getRandomDeposit() -> Double {
        return Double(Int.random(in: 1000...10000))
    }
    
    private func getRandomProfit() -> Double {
        return Double(Int.random(in: 10000...100000))
    }

    private func updateData() {
        for index in traders.indices {
            let randomProfit = Double(Int.random(in: -150...50))
            traders[index].profit += randomProfit
        }
        traders.sort(by: { $0.profit > $1.profit })
    }
}
