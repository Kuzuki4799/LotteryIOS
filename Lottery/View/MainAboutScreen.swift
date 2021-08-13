//
//  MainScreen.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI

struct MainAboutScreen: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack{
            Image("logo").renderingMode(.original).resizable().scaledToFill().frame(width: 200, height: 200).padding(.top, 40)                     .matchedGeometryEffect(id: "image", in: animation)
            
            if self.homeViewModel.mainState == MainState.INFORMATION{
                Text(" AE188 App - là ứng dụng giải trí trực tuyến bom tấn đầy đủ các trò chơi game hot. \n Giao diện ứng dụng dễ sử dụng, bạn có thể dễ dàng đăng ký, đăng nhập và nhận khuyến mại từ nhà tài trợ. \n Chăm sóc khách hàng chuyên nghiệp, đội ngủ hỗ trợ, admin, support túc trực 24/7. \n Ứng dụng được thiết kế với giao diện sống động và được tối ưu hóa kết nối 3G/4G hay wifi. \n Trải nghiệm nhiều điểm nổi bật nhất từ ứng dụng của chúng tôi ngay hôm nay! \n Cảm ơn các bạn!").font(.callout).padding(20).foregroundColor(.white)
            }else{
            Button(action: {
                        self.homeViewModel.showWebView.toggle()
                        self.homeViewModel.linkState = LinkState.REGISTER
                    }, label: {
                    Text("Register").font(.title2).bold().foregroundColor(.white).padding(15).background(Image("button").resizable().scaledToFill()).padding(.top, 10)
                }).offset(x: self.homeViewModel.animationFinished ? 0 : -500)
     
                Button(action: {
                    self.homeViewModel.showWebView.toggle()
                    self.homeViewModel.linkState = LinkState.LOGIN
            }, label: {
                Text("Login").font(.title2).bold().foregroundColor(.white).padding(15).background(Image("button").resizable().scaledToFill()).padding(.top, 10)
            }).offset(x: self.homeViewModel.animationFinished ? 0 : 500)
            
                Button(action: {
                        self.homeViewModel.showWebView.toggle()
                        self.homeViewModel.linkState = LinkState.PROMOTION
                }, label: {
                Text("Promotion").font(.title2).bold().foregroundColor(.white).padding(15).background(Image("button").resizable().scaledToFill()).padding(.top, 10)
            }).offset(x: self.homeViewModel.animationFinished ? 0 : -500)
                
                Button(action: {
                    if self.homeViewModel.checkLinkIsEmpty(url: self.homeViewModel.link.contact){
                        UIApplication.shared.open(URL(string: self.homeViewModel.link.contact)!)
                    }
                }, label: {
                Text("Support").font(.title2).bold().foregroundColor(.white).padding(15).background(Image("button").resizable().scaledToFill()).padding(.top, 10)
            }).offset(x: self.homeViewModel.animationFinished ? 0 : 500)
            }
        }
        .blur(radius: self.homeViewModel.showCustomerCart ? 50 : 0)
    }
}
