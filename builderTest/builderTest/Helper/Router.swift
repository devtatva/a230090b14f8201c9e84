//
//  Router.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import Foundation
import Alamofire

protocol Routable {
    var path: String {get}
    var methods: HTTPMethod {get}
    var parameters: Parameters? {get}
}

enum Router: Routable {
    
    typealias T = Codable.Type
    
    case getPostHits(tags: String, page: Int )
}

extension Router {
    var path:String {
        switch self {
        case .getPostHits(let tags, let page):
            return Environment.APIBasePath() + "search_by_date?tags=\(tags)&page=\(page)"
        }
    }
    
    var methods: HTTPMethod {
        switch self {
        case .getPostHits:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPostHits:
            return nil
        }
    }
}
