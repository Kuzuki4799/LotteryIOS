//
//  WebView.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI
import WebKit

//struct WebView: UIViewRepresentable {
//
//    var url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//
//        let view = WKWebView()
//        view.load(URLRequest(url: url))
//        view.isUserInteractionEnabled = false
//
//        // Scaling WEb View...
//        view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
//        return view
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//
//    }
//}

import SafariServices

struct WebView: UIViewControllerRepresentable{
    
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        print(url.absoluteString)
        let controller = SFSafariViewController(url: url)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

