//
//  HomeView.swift
//  Lottery
//
//  Created by Nguyen Tri The on 29/07/2021.
//

import SwiftUI

struct HomeScreen: View {
    
    var animation: Namespace.ID
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            if self.homeViewModel.showNavigation{
                NavigationMenu()
            }
            ZStack(content: {
                VStack(spacing: 0, content: {
                    HStack{
                        Button(action: {
                            withAnimation{ self.homeViewModel.showNavigation.toggle() }
                        }) {
                            Image(systemName:self.homeViewModel.showNavigation ? "xmark" :"line.horizontal.3")
                                .resizable()
                                .frame(width: self.homeViewModel.showNavigation ? 18 : 22, height: 18)
                                .foregroundColor(Color.yellow)
                        }
                        Spacer()
                    }
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding()
                    
                    MainAboutScreen(animation: self.animation)
                    Spacer()
                })
                if self.homeViewModel.mainState == .CUSTOMER {
                    CustomerView().offset(y: self.homeViewModel.showCustomerCart ? 0 : 1000)
                }
            })
            .alert(isPresented: self.$homeViewModel.isLinkUrlIsEmpty, content: {
                Alert(title: Text("Message"), message: Text("No network, please try again later"), dismissButton: .default(Text("OK"), action: {
                    self.homeViewModel.openSettingContact()
                }))
            })
            .alert(isPresented: self.$homeViewModel.isPermissionContactDenied, content: {
                Alert(title: Text("Permission Denied"), message: Text("Please Access Permission In Settings"), dismissButton: .default(Text("OK"), action: {
                    self.homeViewModel.openSettingContact()
                }))
            })
            .sheet(isPresented: self.$homeViewModel.showSheetShare, content: {
                ShareSheet(items: self.homeViewModel.contentShare)
            })
            .sheet(isPresented: self.$homeViewModel.showWebView, content: {
                if self.homeViewModel.linkState == .REGISTER{
                    if self.homeViewModel.checkLinkIsEmpty(url: self.homeViewModel.link.register){
                        RegisterScreen(linkRegister: self.homeViewModel.link.register)
                    }
                }else if self.homeViewModel.linkState == .LOGIN{
                    if self.homeViewModel.checkLinkIsEmpty(url: self.homeViewModel.link.login){
                        WebScreen(url: self.homeViewModel.link.login)
                    }
                }else if self.homeViewModel.linkState == .PROMOTION{
                    if self.homeViewModel.checkLinkIsEmpty(url: self.homeViewModel.link.login){
                        WebScreen(url: self.homeViewModel.link.promotion)
                    }
                }
            })
            .background(Image("background").centerCropped().edgesIgnoringSafeArea(.all))
            .cornerRadius(self.homeViewModel.showNavigation ? 30 : 0)
            .scaleEffect(self.homeViewModel.showNavigation ? 0.9 : 1)
            .offset(x: self.homeViewModel.showNavigation ? UIScreen.main.bounds.width / 2 : 0, y: self.homeViewModel.showNavigation ? 15 : 0)
            .rotationEffect(.init(degrees: self.homeViewModel.showNavigation ? -5 : 0))
        }
        .onAppear(perform: {
            homeViewModel.getLink()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(Animation.easeIn.speed(0.5)){
                    self.homeViewModel.animationFinished.toggle()
                }
            }
            
            self.homeViewModel.getContact()
        })
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        .environmentObject(homeViewModel)
    }
}


