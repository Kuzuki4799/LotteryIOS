//
//  ShareSheet.swift
//  Lottery
//
//  Created by Nguyen Tri The on 31/07/2021.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable{
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
