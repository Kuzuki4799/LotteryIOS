//
//  LotteryApp.swift
//  Lottery
//
//  Created by Nguyen Tri The on 29/07/2021.
//

import SwiftUI
import Firebase

@main
struct LotteryApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
