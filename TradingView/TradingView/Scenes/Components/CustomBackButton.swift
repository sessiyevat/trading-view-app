//
//  CustomBackButton.swift
//  TradingView
//
//  Created by Tomiris S. on 12/17/23.
//

import SwiftUI

struct CustomBackButton<Item: View>: View {
    @Environment(\.presentationMode) var presentationMode
    let icon: Item

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            icon
        }
    }
}
