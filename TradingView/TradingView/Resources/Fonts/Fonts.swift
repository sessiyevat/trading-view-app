//
//  Fonts.swift
//  TradingView
//
//  Created by Tomiris S. on 12/16/23.
//

import SwiftUI

class Fonts {
    
    enum FontWeight: String {
        case regular = "Regular"
        case bold = "Bold"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case extraBold = "ExtraBold"
    }
    
    static let shared = Fonts()
    
    private init() {}

    func customFont(weight: FontWeight, size: CGFloat) -> Font {
        return Font.custom("Inter-\(weight.rawValue)", size: size)
    }
}
