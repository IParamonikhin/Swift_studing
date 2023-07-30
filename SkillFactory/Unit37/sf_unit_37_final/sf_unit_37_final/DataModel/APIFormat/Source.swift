//
//  Source.swift
//  sf_unit_37_final
//
//  Created by Иван on 13.10.2023.
//

import Foundation


class Source {
    let id: ID?
    let name: Name

    init(id: ID?, name: Name) {
        self.id = id
        self.name = name
    }
}

enum ID: String {
    case engadget
    case wired
}

enum Name: String {
    case engadget
    case lifehackerCOM
    case wired
}
