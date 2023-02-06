//
//  Post.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import Foundation

struct Post : Codable {
    
    let hits : [Hits]?
    let nbPages: Int?
    let hitsPerPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case hits = "hits"
        case nbPages = "nbPages"
        case hitsPerPage = "hitsPerPage"
    }
}

struct Hits : Codable {
    let created_at : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case title = "title"
    }
}

