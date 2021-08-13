//
//  RegisterScreen.swift
//  Lottery
//
//  Created by Nguyen Tri The on 29/07/2021.
//

import SwiftUI

struct RegisterScreen: View {
    
    var linkRegister: String
    
    @StateObject var registerViewModel = RegisterViewModel()
    
    var body: some View {
        ZStack{
        VStack{
            Image("logo").renderingMode(.original).resizable().scaledToFill().frame(width: 200, height: 200).padding(.top, 40)
            
            TextField("",text: self.$registerViewModel.name)
                .placeholder(when: self.registerViewModel.name.isEmpty, placeholder: {
                    Text("Enter name here").foregroundColor(.gray)
                })
                .keyboardType(.default)
                .textContentType(.name)
                .padding(10).font(.title2).foregroundColor(.white)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 2))
                .padding(.horizontal, 50).padding(.top, 50)
                .offset(x: self.registerViewModel.animationFinished ? 0 : -500)
            
            TextField("",text: self.$registerViewModel.phone)
                .placeholder(when: self.registerViewModel.phone.isEmpty, placeholder: {
                    Text("Enter phone here").foregroundColor(.gray)
                })
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
                .padding(10).font(.title2).foregroundColor(.white)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 2))
                .padding(.horizontal, 50).padding(.top, 10)
                .offset(x: self.registerViewModel.animationFinished ? 0 : 500)
            
            Button(action: {
                self.registerViewModel.pushRegister()
            }, label: {
                Text("Register").font(.title2).bold().foregroundColor(.white).padding(15).background(Image("button").resizable().scaledToFill()).padding(.top, 10)
            }).offset(x: self.registerViewModel.animationFinished ? 0 : -500)
          
            Spacer()
        }
            if self.registerViewModel.isRegistered  {
                ZStack{
                    Color.black.edgesIgnoringSafeArea(.all)
                    WebView(url: URL(string: linkRegister)!)
                }
            }
        }.background(Image("background").centerCropped().edgesIgnoringSafeArea(.all))
        .alert(isPresented: self.$registerViewModel.isShowAlertError, content: {
            Alert(title: Text("Error"), message: Text(self.registerViewModel.errMessage), dismissButton: .default(Text("OK")))
        })
        .onAppear(perform: {
            self.registerViewModel.isRegistered = UserDefaults.standard.object(forKey: "registered") as? Bool ?? false
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(Animation.easeIn.speed(0.5)){
                    self.registerViewModel.animationFinished.toggle()
                }
                self.registerViewModel.getAmountFirebase()
            }
        })
    }
}
