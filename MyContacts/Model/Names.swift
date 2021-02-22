//
//  Names.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 10.02.2021.
//

import Foundation
import Contacts

struct Names {
    var isExpandable: Bool
    var names: [Contact]
}

struct Contact {
    let contact: CNContact
    var isFavorite: Bool
}
