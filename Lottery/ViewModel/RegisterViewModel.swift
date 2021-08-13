//
//  RegisterViewModel.swift
//  Lottery
//
//  Created by Nguyen Tri The on 01/08/2021.
//

import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    
    @Published var name = ""
    
    @Published var phone = ""
    
    @Published var amount = 0
    
    @Published var errMessage = ""
    
    @Published var isRegistered = false
    
    @Published var isShowAlertError = false
    
    @Published var animationFinished = false
    
    let ref = Database.database().reference()
    
    let dateFormatter = DateFormatter()
    
    let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    func getAmountFirebase(){
        Database.database().reference().child("amount").getData { err, snapShot in
            print((snapShot.value as! Int))
            self.amount = snapShot.value as! Int
        }
    }
    
    func pushRegister(){
        if name.isEmpty{
            self.errMessage = "Please enter name!!!"
            self.isShowAlertError.toggle()
        }else if(phone.isEmpty){
            self.errMessage = "Please enter phone!!!"
            self.isShowAlertError.toggle()
        }else{
            Database.database().reference().child("amount").setValue(amount + 1)
            ref.child("data" + "/" + UIDevice.current.identifierForVendor!.uuidString + "/" + phone)
                .setValue(["createdate": stackDateFormat.string(from: Date()),
                           "phonenumber": phone,
                           "username": name
                ])
            UserDefaults.standard.set(true, forKey: "registered")
            self.isRegistered = true
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
             print("validate emilId: \(testStr)")
             let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
             let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             let result = emailTest.evaluate(with: testStr)
             return result
         }
    
    func isValidatePhone(value: String) -> Bool {
            let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            let result = phoneTest.evaluate(with: value)
            return result
        }
}
