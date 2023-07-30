//
//  Article.swift
//  sf_unit_37_final
//
//  Created by Иван on 13.10.2023.
//

import Foundation


class Article {
    let source: Source
    let author, title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String

    init(source: Source, author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: Date, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
