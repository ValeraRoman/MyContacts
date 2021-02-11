//
//  Names.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 10.02.2021.
//

import Foundation

struct Names {
    var isExpandable: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    let number: String
    var isFavorite: Bool
}
