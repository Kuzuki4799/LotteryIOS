//
//  CustomerView.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI

struct CustomerView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10, content: {
            Text("Message").fontWeight(.bold).foregroundColor(.gray)
            
            Text("Customer's code").font(.title2).fontWeight(.bold).foregroundColor(.black)
            
            Text(UIDevice.current.identifierForVendor!.uuidString).font(.title3).fontWeight(.semibold)
                .foregroundColor(.black).padding(20)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)){
                    self.homeViewModel.showCustomerCart.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.homeViewModel.mainState = MainState.HOME
                    }
                }
            }, label: {
                Text("Copy").fontWeight(.bold).foregroundColor(.white).padding(.vertical).frame(maxWidth: .infinity)
                    .background(Color.red).cornerRadius(18)
            })
        }).padding(.horizontal).padding(.vertical, 20).background(Color.white).cornerRadius(20)
        .overlay(
            Capsule().fill(Color.red).frame(width: 4, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.top, 45), alignment: .topLeading
        ).padding()
    }
}

struct CustomerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerView()
    }
}

