//
//  WebView.swift
//  TradingView
//
//  Created by Tommy on 12/14/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url ?? URL(fileURLWithPath: "/"))
        uiView.load(request)
    }
}
