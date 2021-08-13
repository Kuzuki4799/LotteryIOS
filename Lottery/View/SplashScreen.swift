//
//  SplashScreen.swift
//  Lottery
//
//  Created by Nguyen Tri The on 29/07/2021.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var animate = false
    
    @State private var hasDone = false
    @Namespace var animation
    
    var body: some View {
        
        ZStack{
          Image("background").centerCropped().edgesIgnoringSafeArea(.all)
            VStack{
                Image("logo").renderingMode(.original).resizable().scaledToFill().frame(width: 200, height: 200).matchedGeometryEffect(id: "image", in: animation)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5.0)
                        .opacity(0.3)
                        .foregroundColor(Color.red)
                    
                    Circle()
                        .trim(from: 0.0, to: 0.3)
                        .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.red)
                        .rotationEffect(.init(degrees: animate ? 360 : 0))
                }.frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).shadow(radius: 30)
                .onAppear(perform: {
                    withAnimation(Animation.linear.speed(0.6).repeatForever(autoreverses: false)){
                        animate.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.spring()){
                            self.hasDone.toggle()
                            }
                        }
                    }
                })
            }
            
            if hasDone{ HomeScreen(animation: animation) }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
