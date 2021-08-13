//
//  ContactModel.swift
//  Lottery
//
//  Created by Nguyen Tri The on 01/08/2021.
//

import SwiftUI
import Contacts

struct ContactModel: Identifiable {
    var id: String {contact.identifier}
    var name: String {contact.familyName + contact.givenName}
    var phone: String { contact.phoneNumbers.map(\.value).first?.stringValue ?? ""}
    
    let contact: CNContact
}
