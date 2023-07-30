//
//  Constans.swift
//  sf_unit_37_final
//
//  Created by Иван on 13.10.2023.
//

import Foundation

let privatToken = "b429f2cb85da4a80bc96b1f41c44fc08"
let initialURL = "https://newsapi.org/"
let apiURL = initialURL + "v2/everything?q=Apple&sortBy=popularity&apiKey=" + privatToken

typealias GetComplete = () -> ()
