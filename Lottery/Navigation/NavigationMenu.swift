//
//  NavigationMeny.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI

struct NavigationMenu: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 12) {
                
                Image("logo_horizon")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 150, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    withAnimation{
                        self.homeViewModel.showNavigation.toggle()
                        self.homeViewModel.mainState = MainState.HOME
                    }
                }) {
                    HStack(spacing: 25){
                        Image(systemName: "house")
                            .foregroundColor(self.homeViewModel.mainState == MainState.HOME ? Color("ColorPrimary") : Color.white)

                        Text("Home")
                        .foregroundColor(self.homeViewModel.mainState == MainState.HOME ? Color("ColorPrimary") : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.homeViewModel.mainState == MainState.HOME ? Color("ColorPrimary").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                .padding(.top,25)
                
                Button(action: {
                    withAnimation{
                        self.homeViewModel.showNavigation.toggle()
                        self.homeViewModel.mainState = MainState.CUSTOMER
                    }
                    
                    withAnimation(.easeInOut(duration: 0.7)){
                        self.homeViewModel.showCustomerCart.toggle()
                    }
                }) {
                    HStack(spacing: 25){
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(self.homeViewModel.mainState == MainState.CUSTOMER ? Color("ColorPrimary") : Color.white)
                        
                        Text("Customer")
                        .foregroundColor(self.homeViewModel.mainState == MainState.CUSTOMER ? Color("ColorPrimary") : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.homeViewModel.mainState == MainState.CUSTOMER ? Color("ColorPrimary").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    withAnimation{
                        self.homeViewModel.showNavigation.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()){
                            self.homeViewModel.contentShare.removeAll()
                            self.homeViewModel.contentShare.append(String("https://apps.apple.com/app/id" + Bundle.main.bundleIdentifier!))
                            self.homeViewModel.showSheetShare.toggle()
                        }
                   }
                }) {
                    HStack(spacing: 25){
                        Image(systemName: "square.and.arrow.up").foregroundColor(Color.white)
                        
                        Text("Share App").foregroundColor(Color.white)
                    }
                    .padding(.vertical, 10).padding(.horizontal).background(Color.clear)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    withAnimation{
                        self.homeViewModel.showNavigation.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()){
                                UIApplication.shared.open(URL(string: String("https://apps.apple.com/app/id" + Bundle.main.bundleIdentifier!))!)
                            }
                       }
                        
                    }
                }) {
                    HStack(spacing: 25){
                        Image(systemName: "star.circle").foregroundColor(Color.white)

                        Text("Rate App").foregroundColor(Color.white)
                    }
                    .padding(.vertical, 10).padding(.horizontal).background(Color.clear)
                    .cornerRadius(10)
                }

                Button(action: {
                    withAnimation{
                        self.homeViewModel.showNavigation.toggle()
                        self.homeViewModel.mainState = MainState.INFORMATION
                    }
                }) {
                    HStack(spacing: 25){
                        Image(systemName: "info.circle")
                            .foregroundColor(self.homeViewModel.mainState == MainState.INFORMATION ? Color("ColorPrimary") : Color.white)

                        Text("Information")
                        .foregroundColor(self.homeViewModel.mainState == MainState.INFORMATION ? Color("ColorPrimary") : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.homeViewModel.mainState == MainState.INFORMATION ? Color("ColorPrimary").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top,25)
            .padding(.horizontal,20)
            
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}

struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
