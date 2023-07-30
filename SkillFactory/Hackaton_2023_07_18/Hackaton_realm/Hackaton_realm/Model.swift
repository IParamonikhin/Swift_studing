//
//  Model.swift
//  Hackaton_realm
//
//  Created by Иван on 27.07.2023.
//

import Foundation
import RealmSwift


class Model: Object {
    @objc dynamic var timeAndDate: String = ""
    @objc dynamic var operation: String = ""
    @objc dynamic var target: String = ""
    @objc dynamic var sum: Float = 0.0
    @objc dynamic var type: String = ""
}

class Balance: Object{
    @objc dynamic var balance: Float = 0.0
}
