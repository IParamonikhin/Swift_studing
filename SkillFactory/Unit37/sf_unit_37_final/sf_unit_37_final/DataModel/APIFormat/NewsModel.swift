//
//  NewsModel.swift
//  sf_unit_37_final
//
//  Created by Иван on 13.10.2023.
//

import Foundation
import RealmSwift
import ObjectMapper

class NewsModel: Object, Mappable, DBModel {
    
    let status: String
    let totalResults: Int
    let articles: [Article]

    init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
    
    required init?(map: ObjectMapper.Map) {
        <#code#>
    }
    
    static func urlAPI() -> String {
        return apiURL
    }
    
    func mapping(map: ObjectMapper.Map) {
        <#code#>
    }
    
    
}
