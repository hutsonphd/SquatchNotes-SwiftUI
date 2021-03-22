//
//  WKWebView.swift
//  SquatchNotes
//
//  Created by Hutson on 3/20/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
