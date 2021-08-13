//
//  WebScreen.swift
//  Lottery
//
//  Created by Nguyen Tri The on 29/07/2021.
//

import SwiftUI

struct WebScreen: View {
    var url: String
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            WebView(url: URL(string: url)!)
        }
    }
}

struct WebScreen_Previews: PreviewProvider {
    static var previews: some View {
        WebScreen(url: "https://kavsoft.dev/SwiftUI_2.0/Animated_Navigation_Menu")
    }
}
