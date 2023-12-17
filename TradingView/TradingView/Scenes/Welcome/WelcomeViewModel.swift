//
//  WelcomeViewModel.swift
//  TradingView
//
//  Created by Tomiris S. on 12/13/23.
//

import SwiftUI
import Combine

final class WelcomeViewModel: ObservableObject {
    
    @Published var isPreloadingDone: Bool = false
    @Published var loadingPercent: CGFloat = 0

    private var notificationRequested = false
    private var cancellables: Set<AnyCancellable> = []

    init() {
        setupBinding()
    }

    private func setupBinding() {
        Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.loadingPercent += 20
                self.loadingPercent = min(self.loadingPercent, 100)
                
                if self.loadingPercent == 100 {
                    self.isPreloadingDone = true

                    if !self.notificationRequested {
                        self.requestNotificationPermission()
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
            self.notificationRequested = true
        }
    }
}
