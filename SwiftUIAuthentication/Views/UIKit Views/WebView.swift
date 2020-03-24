//
//  WebView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 22/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL
    @Binding var isLoading: Bool
    @Binding var error: NSError?
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = UIColor.systemBackground
        webView.navigationDelegate = context.coordinator
        webView.scrollView.contentInset = .zero
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {}
    
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(isLoading: $isLoading, error: $error)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        @Binding var isLoading: Bool
        @Binding var error: NSError?
        
        init(isLoading: Binding<Bool>, error: Binding<NSError?>) {
            self._isLoading = isLoading
            self._error = error
            super.init()
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.isLoading = true
                self.error = nil
            }
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.isLoading = false
                self.error = error as NSError
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
