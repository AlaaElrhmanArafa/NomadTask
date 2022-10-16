//
//  EndPoints.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation

struct API {
    static let baseUrl = "https://run.mocky.io/v3/"
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum Endpoints {
    case products
    
    public var path: String {
        switch self{
        case .products:
            return "4e23865c-b464-4259-83a3-061aaee400ba"
        }
    }
    
    public var url: String {
        return "\(API.baseUrl)\(path)"
    }
    
    public var httpMethod: HTTPMethod {
        switch self{
        case .products:
            return .get
        }
    }
}
