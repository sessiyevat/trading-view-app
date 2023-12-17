//
//  String+Extensions.swift
//  TradingView
//
//  Created by Tomiris S. on 12/18/23.
//

import Foundation

extension String {
    func formatTimer() -> String {
        var formattedText = self
        formattedText.removeAll { !$0.isNumber }
        
        if formattedText.count > 4 {
            formattedText = String(formattedText.prefix(4))
        }
        
        if formattedText.count > 2 {
            formattedText.insert(":", at: formattedText.index(formattedText.startIndex, offsetBy: 2))
        }
        
        return formattedText
    }
    
    func parseSeconds() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"

        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute, .second], from: date)
            
            if let minutes = components.minute, let seconds = components.second {
                return minutes * 60 + seconds
            }
        }
        
        return .zero
    }
}
